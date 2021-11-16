function Get-SCOMInfo {

    Param(
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        ##Check for program in Add/Remove Programs
        $keypaths = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
        $SCOM = foreach ($path in $keypaths){Get-ItemProperty $path | 
                Where-Object {$_.Displayname -like "Microsoft Monitoring Agent"} | Sort-Object DisplayName |
                        Select-Object @{N='Name';E={$_.DisplayName}}, @{N='Version';E={$_.DisplayVersion}}, Publisher, InstallDate,UninstallString,InstallLocation,InstallSource}
        # Get Agent Settings
        if ($SCOM){
            $Agent = New-Object -ComObject AgentConfigManager.MgmtSvcCfg
            $ServiceStatus = (Get-Service HealthService).Status.ToString()
            $apmstatus = try {(Get-Service "System Center Management APM" -ErrorAction Stop).StartType.ToString()}catch {"NotInstalled"}
            $dllversion = (Get-ItemProperty -Path "C:\Program Files\Microsoft Monitoring Agent\Agent\HealthServiceRuntime.dll").versioninfo.fileversion
            $ManagementGroupInfoRaw = $agent.GetManagementGroups()
            $ADIntegrationEnabled = try{$agent.GetActiveDirectoryIntegrationEnabled()}catch{try{$agent.ActiveDirectoryIntegrationEnabled()}catch{}}
            $LocalCollectionEnabled = try{$agent.GetLocalCollectionEnabled()}catch{try{$agent.LocalCollectionEnabled()}catch{}}
            $proxyURL = try{$agent.proxyURL}catch{}
            $proxyUsername = try{$agent.proxyUsername}catch{}
            #iterate through management group info can be mutli value, especially during migration
            $ManagementGroupInfo = @()
            foreach ($info in $ManagementGroupInfoRaw){
                $mgobject = [PSCustomObject]@{
                    managementGroupName = $info.managementGroupName
                    ManagementServer = $info.ManagementServer
                    managementServerPort = $info.managementServerPort
                    IsManagementGroupFromActiveDirectory = $info.IsManagementGroupFromActiveDirectory
                    ActionAccount = $info.ActionAccount
                }
                $ManagementGroupInfo += $mgobject
            }
        }
        else {
            Write-Warning "[ $env:COMPUTERNAME ] :: SCOM is not installed."
            $ManagementGroupInfo = @()
        }

        $object = [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            SCOMVersionInstalled = $SCOM.version
            SCOMInstallDate = $scom.installdate
            DLLVersion = $dllversion
            ServiceStatus = $ServiceStatus
            APMStatus = $apmstatus
            ADIntegrationEnabled = $ADIntegrationEnabled
            LocalCollectionEnabled = $LocalCollectionEnabled
            ManagementGroupInfo1 = if ($ManagementGroupInfo[0]){($ManagementGroupInfo[0] -join ";").tostring()}else {}
            ManagementGroupInfo2 = if ($ManagementGroupInfo[1]){($ManagementGroupInfo[1] -join ";").tostring()}else {}
            ManagementGroupInfo3 = if ($ManagementGroupInfo[2]){($ManagementGroupInfo[2] -join ";").tostring()}else {}
            proxyURL = $proxyURL
            proxyUsername = $proxyUsername

        }
        return $object

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
