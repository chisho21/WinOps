function Get-SCCMPrePatchAudit {
    Param (
        [Parameter(Mandatory=$true,
                    Position=0)]
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    Write-Host "Working through $($ComputerName.count) Servers... Please HOLD..." -ForegroundColor Yellow

    #Set Tables
    $finaltable = @()
    $timestamp = Get-date

    ##Setup Scriptblock to run on remotecomptuers
    $scriptblock =  {
            ##B01-Get SCCM OS Update status    
            $Updates =  (Get-CimInstance -Namespace "root\ccm\clientsdk" -Class CCM_SoftwareUpdate ).count
            
            
        ##B02-Define and Run Test-PendingReboot
            function Test-PendingReboot
            {
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
            $rebootinfo = Test-PendingReboot -Detailed
            
            ##B03-GetStandardUpdateInfo
            #Disk Info
                $disk = Get-CimInstance Win32_LogicalDisk -Filter DriveType=3 | 
                            Where-Object {$_.DeviceID -like "C:"} |
                            Select-Object DeviceID, @{'Name'='Size (GB)'; 'Expression'={[math]::truncate($_.size / 1GB)}}, @{'Name'='Freespace (GB)'; 'Expression'={[math]::truncate($_.freespace / 1GB)}}
            
            #cache Info
                $path = "C:\Windows\ccmcache"
                $cachesize = ((Get-ChildItem $path -Recurse -file | Measure-Object -Property Length -Sum -ErrorAction Stop).Sum / 1MB)
                $recentfoldercount = (Get-childitem $path | Where-Object {$_.lastwritetime -gt (get-date).addDays(-14)}).count
                $totalfoldercount = (Get-childitem $path).count
                $cachesetting = (Get-CimInstance -Namespace ROOT\CCM\SoftMgmtAgent -Query "Select Size from CacheConfig").size
                $clientversion = (Get-CimInstance -Namespace root\ccm -Class SMS_Client).ClientVersion
            #hotfix info
                try {$hf = get-hotfix | Where-Object {$_.installedon} | Sort-Object Installedon | Select-Object -last 1}
                        catch{$hf = ""}
            #last boot
            $boot =  Get-CimInstance -ClassName win32_operatingsystem
            
            $caccheobject = [pscustomobject]@{
                OS = $boot.caption
                LastBootTime = $boot.LastBootUpTime
                ClientVersion = $clientversion
                CDriveSizeGB = $disk.'Size (GB)'
                CDriveFreeGB = $disk.'Freespace (GB)'
                FoldersizeMB = $cachesize
                TotalCacheFoldercount = $totalfoldercount
                RecentCacheFoldercount = $recentfoldercount
                CacheSettingMB = $cachesetting
                HotFixInstalledon = $hf.installedon
                HotfixID = $hf.hotfixid
                HotFixDescription = $hf.Description
                
                }#end object
            
            
            ##B04-SMASH THE DATA TOGETHER
            # $rebootinfo and $Updateinfo(multiple) and $caccheobject
            $smashtable = @()
            
            $smashobject = [PSCustomObject]@{
                    ComputerName = $env:COMPUTERNAME
                    PendingUpdateCount = $Updates
                    OS = $caccheobject.OS
                    LastBootTime = $caccheobject.LastBootTime
                    ClientVersion =  $caccheobject.ClientVersion
                    CDriveSizeGB =  $caccheobject.CDriveSizeGB
                    CDriveFreeGB =  $caccheobject.CDriveFreeGB
                    FoldersizeMB =  $caccheobject.FoldersizeMB
                    TotalCacheFoldercount =  $caccheobject.TotalCacheFoldercount
                    RecentCacheFoldercount =  $caccheobject.RecentCacheFoldercount
                    CacheSettingMB =  $caccheobject.CacheSettingMB
                    HotFixInstalledon =  $caccheobject.HotFixInstalledon
                    HotfixID =  $caccheobject.HotfixID
                    HotFixDescription =  $caccheobject.HotFixDescription
                    IsRebootPending  = $rebootinfo.IsRebootPending
                    ComponentBasedServicing  = $rebootinfo.ComponentBasedServicing
                    PendingComputerRenameDomainJoin = $rebootinfo.PendingComputerRenameDomainJoin
                    PendingFileRenameOperations = $rebootinfo.PendingFileRenameOperations
                    PendingFileRenameOperationsValue = $rebootinfo.PendingFileRenameOperationsValue
                    SystemCenterConfigManager = $rebootinfo.SystemCenterConfigManager
                    WindowsUpdateAutoUpdate = $rebootinfo.WindowsUpdateAutoUpdate
            }
            $smashtable += $smashobject

            return $smashtable

        }#EndScriptblock 

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
    $null = invoke-command @params -outvariable data -ErrorVariable myerr -ThrottleLimit 75 


    ## Combine Errors and Results

    foreach ($dat in $data){
        $object = [PSCustomObject]@{
            ComputerName = $dat.ComputerName
            TimeStamp = $timestamp
            PendingUpdateCount = $dat.PendingUpdateCount
            OS = $dat.os
            LastBootTime = $dat.LastBootTime
            ClientVersion =  $dat.ClientVersion
            CDriveSizeGB =  $dat.CDriveSizeGB
            CDriveFreeGB =  $dat.CDriveFreeGB
            FoldersizeMB =  $dat.FoldersizeMB
            TotalCacheFoldercount =  $dat.TotalCacheFoldercount
            RecentCacheFoldercount =  $dat.RecentCacheFoldercount
            CacheSettingMB =  $dat.CacheSettingMB
            HotFixInstalledon =  $dat.HotFixInstalledon
            HotfixID =  $dat.HotfixID
            HotFixDescription =  $dat.HotFixDescription
            IsRebootPending  = $dat.IsRebootPending
            ComponentBasedServicing  = $dat.ComponentBasedServicing
            PendingComputerRenameDomainJoin = $dat.PendingComputerRenameDomainJoin
            PendingFileRenameOperations = $dat.PendingFileRenameOperations
            #PendingFileRenameOperationsValue = $dat.PendingFileRenameOperationsValue
            SystemCenterConfigManager = $dat.SystemCenterConfigManager
            WindowsUpdateAutoUpdate = $dat.WindowsUpdateAutoUpdate
            Error = ""
        }#end object
    $finaltable += $object
    }#end foreach dat

    foreach ($dat in $myerr){
        $object = [PSCustomObject]@{
            ComputerName = $dat.targetobject
            TimeStamp = $timestamp
            PendingUpdateCount = ""
            OS = ""
            LastBootTime = ""
            ClientVersion =  ""
            CDriveSizeGB =  ""
            CDriveFreeGB =  ""
            FoldersizeMB =  ""
            TotalCacheFoldercount =  ""
            RecentCacheFoldercount =  ""
            CacheSettingMB =  ""
            HotFixInstalledon =  ""
            HotfixID =  ""
            HotFixDescription =  ""
            IsRebootPending  = ""
            ComponentBasedServicing  = ""
            PendingComputerRenameDomainJoin = ""
            PendingFileRenameOperations = ""
            #PendingFileRenameOperationsValue = ""
            SystemCenterConfigManager = ""
            WindowsUpdateAutoUpdate = ""
            Error = $dat.FullyQualifiedErrorId
        }#end object
        $finaltable += $object
    }#end foreach ERR

    $overalltime = $vcenterstopwatch.elapsed.totalseconds
    Write-Host "All SERVER connections completed in $overalltime seconds."
    return $finaltable

}
