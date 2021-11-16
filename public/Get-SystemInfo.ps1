function Get-SystemInfo {
    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        [Switch]
        $HotFixInfo,
        [System.Management.Automation.PSCredential]
        $Credential

    )

    $scriptblock = {

        $System = Get-CimInstance -Class Win32_ComputerSystem 
        $OS = Get-CimInstance -Class Win32_OperatingSystem 
        $BIOS = Get-CimInstance -Class Win32_BIOS
        $Processor = Get-CimInstance -Class Win32_Processor 
        $Network = Get-CimInstance -Class Win32_NetworkAdapterConfiguration 
        $Disk = Get-CimInstance -Class Win32_LogicalDisk 
        $Uptime = New-TimeSpan $OS.LastBootUpTime $OS.LocalDateTime -ErrorAction SilentlyContinue
        $TimeZone = try{(Get-TimeZone).Displayname} catch{"ERROR"}
        $properties = @(
            @{n='TimeStamp';e={$_.TimeCreated}},
            @{n='User';e={$_.Properties[6].Value}},
            @{n='Reason/Application';e={$_.Properties[0].Value}},
            @{n='Action';e={$_.Properties[4].Value}}
        )
        $reboot = Get-WinEvent -FilterHashTable @{LogName='System'; ID=1074} | Sort-Object TimeCreated -Descending | Select-Object $properties -First 1
        if ($using:HotFixInfo){
            $hotfix = (Get-HotFix | Sort-Object InstalledOn -Descending | Select-Object hotfixID,InstalledOn,InstalledBy)[0]
        }
        #Get Pending reboot info - Stolen from Adam Bertram's Test-Pending Reboot https://www.powershellgallery.com/packages/Test-PendingReboot
        function Test-PendingReboot{
            [CmdletBinding()]
            param(
                [Parameter(Position = 0, ValueFromPipeline = $true, ValueFromPipelineByPropertyName = $true)]
                [Alias("CN", "Computer")]
                [String[]]
                $ComputerName,

                [Parameter()]
                [Switch]
                $Detailed,

                [Parameter()]
                [Switch]
                $SkipConfigurationManagerClientCheck,

                [Parameter()]
                [Switch]
                $SkipPendingFileRenameOperationsCheck
            )

                foreach ($computer in $ComputerName)
                {
                        $invokeWmiMethodParameters = @{
                            Namespace    = 'root/default'
                            Class        = 'StdRegProv'
                            Name         = 'EnumKey'
                            ErrorAction  = 'Stop'
                        }

                        $hklm = [UInt32] "0x80000002"

                        ## Query the Component Based Servicing Reg Key
                        $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SOFTWARE\Microsoft\Windows\CurrentVersion\Component Based Servicing\')
                        $registryComponentBasedServicing = (Invoke-WmiMethod @invokeWmiMethodParameters).sNames -contains 'RebootPending'

                        ## Query WUAU from the registry
                        $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate\Auto Update\')
                        $registryWindowsUpdateAutoUpdate = (Invoke-WmiMethod @invokeWmiMethodParameters).sNames -contains 'RebootRequired'

                        ## Query JoinDomain key from the registry - These keys are present if pending a reboot from a domain join operation
                        $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SYSTEM\CurrentControlSet\Services\Netlogon')
                        $registryNetlogon = (Invoke-WmiMethod @invokeWmiMethodParameters).sNames
                        $pendingDomainJoin = ($registryNetlogon -contains 'JoinDomain') -or ($registryNetlogon -contains 'AvoidSpnSet')

                        ## Query ComputerName and ActiveComputerName from the registry and setting the MethodName to GetMultiStringValue
                        $invokeWmiMethodParameters.Name = 'GetMultiStringValue'
                        $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName\', 'ComputerName')
                        $registryActiveComputerName = Invoke-WmiMethod @invokeWmiMethodParameters

                        $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName\', 'ComputerName')
                        $registryComputerName = Invoke-WmiMethod @invokeWmiMethodParameters

                        $pendingComputerRename = $registryActiveComputerName -ne $registryComputerName -or $pendingDomainJoin

                        ## Query PendingFileRenameOperations from the registry
                        if (-not $PSBoundParameters.ContainsKey('SkipPendingFileRenameOperationsCheck'))
                        {
                            $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SYSTEM\CurrentControlSet\Control\Session Manager\', 'PendingFileRenameOperations')
                            $registryPendingFileRenameOperations = (Invoke-WmiMethod @invokeWmiMethodParameters).sValue
                            $registryPendingFileRenameOperationsBool = [bool]$registryPendingFileRenameOperations
                        }

                        ## Query ClientSDK for pending reboot status, unless SkipConfigurationManagerClientCheck is present
                        if (-not $PSBoundParameters.ContainsKey('SkipConfigurationManagerClientCheck'))
                        {
                            $invokeWmiMethodParameters.NameSpace = 'ROOT\ccm\ClientSDK'
                            $invokeWmiMethodParameters.Class = 'CCM_ClientUtilities'
                            $invokeWmiMethodParameters.Name = 'DetermineifRebootPending'
                            $invokeWmiMethodParameters.Remove('ArgumentList')

                            try
                            {
                                $sccmClientSDK = Invoke-WmiMethod @invokeWmiMethodParameters
                                $systemCenterConfigManager = $sccmClientSDK.ReturnValue -eq 0 -and ($sccmClientSDK.IsHardRebootPending -or $sccmClientSDK.RebootPending)
                            }
                            catch
                            {
                                $systemCenterConfigManager = $null
                                Write-Verbose -Message ($script:localizedData.invokeWmiClientSDKError -f $computer)
                            }
                        }

                        $isRebootPending = $registryComponentBasedServicing -or `
                            $pendingComputerRename -or `
                            $pendingDomainJoin -or `
                            $registryPendingFileRenameOperationsBool -or `
                            $systemCenterConfigManager -or `
                            $registryWindowsUpdateAutoUpdate

                        if ($PSBoundParameters.ContainsKey('Detailed'))
                        {
                            [PSCustomObject]@{
                                ComputerName                     = $computer
                                IsRebootPending                  = $isRebootPending
                                ComponentBasedServicing          = $registryComponentBasedServicing
                                PendingComputerRenameDomainJoin  = $pendingComputerRename
                                PendingFileRenameOperations      = $registryPendingFileRenameOperationsBool
                                PendingFileRenameOperationsValue = $registryPendingFileRenameOperations -join ';'
                                SystemCenterConfigManager        = $systemCenterConfigManager
                                WindowsUpdateAutoUpdate          = $registryWindowsUpdateAutoUpdate
                            }
                        }
                        else
                        {
                            [PSCustomObject]@{
                                ComputerName    = $computer
                                IsRebootPending = $isRebootPending
                            }
                        }
                    }#end Foreach
            
        }#end Fuction
        $pendingreboot = Test-PendingReboot

        $object = [pscustomobject] @{
            ComputerName = $system.name
            Domain = $system.Domain
            OSName = $os.Caption
            OSVersion = $os.version
            OSArch = $os.osarchitecture
            OriginalInstallDate = $os.InstallDate
            Uptime = "{0} days {1} hours {2} minutes" -f $Uptime.Days, $Uptime.Hours, $Uptime.Minutes
            LastReboot = $OS.LastBootUpTime
            LastRebootEvent = $reboot
            IsPendingReboot = $pendingreboot.IsRebootPending
            TimeZone = $TimeZone
            SystemModel = $System.Model
            BIOSVersion = "{0} ({1})" -f $BIOS.Name, $BIOS.Version
            SerialNumber = $BIOS.SerialNumber
            Processor = ($Processor | ForEach-Object {"{0} ({1} Core(s), {2} Logical Processor(s))" -f $_.Name, $_.NumberOfCores, $_.NumberOfLogicalProcessors} | Out-String).Trim()
            TotalCPUCores = $processor.count * $processor[0].NumberOfCores
            RAM = "{0:N2} / {1:N2} GB ({2:N1}% Free)" -f ($OS.FreePhysicalMemory / 1MB), ($OS.TotalVisibleMemorySize / 1MB), (($OS.FreePhysicalMemory / $OS.TotalVisibleMemorySize) * 100)
            LogicalDisks = ($Disk | Where-Object { $_.DriveType -eq 3 -and $_.Size -notlike $null } | ForEach-Object { "[{0}] {1}\ ({2}) = {3:N2} / {4:N2} GB ({5:N1}% Free)" -f $_.FileSystem, $_.DeviceID, $_.VolumeName, ($_.FreeSpace / 1GB), ($_.Size / 1GB), (($_.FreeSpace / $_.Size) * 100) } | Out-String).Trim()
            PSVersion = $psversiontable.psversion.tostring()
            IPAddress = ($network | Where-Object {$_.DefaultIPGateway}).ipaddress -join ","
            IPSubnet = ($network | Where-Object {$_.DefaultIPGateway}).IPSubnet -join ","
            Gateway = ($network | Where-Object {$_.DefaultIPGateway}).DefaultIPGateway -join ","
            DNSServers = ($network | Where-Object {$_.DefaultIPGateway}).DNSServerSearchOrder -join ","
            LastHotFixInstalled = if($hotfix){$hotfix}else{"'HotFixInfo' Flag not set."}
        }

        return $object
    }# end script block

	#Execute Scriptblock on Computername(s) with set parameters.
	$params = @{
		ScriptBlock = $scriptblock
	}
	if ($ComputerName){
		$params['ComputerName'] = $ComputerName
	}
	if ($Credential){
		$params['Credential'] = $Credential
	}
	Invoke-Command @params
}
