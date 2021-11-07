function Get-PendingReboot {

    Param(
        [Parameter(ValueFromPipelineByPropertyName=$true, Mandatory=$true,
            Position=0)]
        $ComputerName,
        [Parameter()]
        [Switch]
        $Detailed,
        [Parameter()]
        [Switch]
        $SkipConfigurationManagerClientCheck,
        [Parameter()]
        [Switch]
        $SkipPendingFileRenameOperationsCheck,
        [System.Management.Automation.PSCredential]
        $Credential
    )
    ## Stolen from Adam Bertram's Test-Pending Reboot https://www.powershellgallery.com/packages/Test-PendingReboot
    [CmdletBinding()]
    $scriptblock = {
        $computer = $env:COMPUTERNAME
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
        if (!$using:SkipPendingFileRenameOperationsCheck)
        {
            $invokeWmiMethodParameters.ArgumentList = @($hklm, 'SYSTEM\CurrentControlSet\Control\Session Manager\', 'PendingFileRenameOperations')
            $registryPendingFileRenameOperations = (Invoke-WmiMethod @invokeWmiMethodParameters).sValue
            $registryPendingFileRenameOperationsBool = [bool]$registryPendingFileRenameOperations
        }

        ## Query ClientSDK for pending reboot status, unless SkipConfigurationManagerClientCheck is present
        if (!$using:SkipConfigurationManagerClientCheck)
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

        if ($using:Detailed)
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
    } # end scriptblock

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
