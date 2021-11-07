function Add-SCOMAgentManagementGroup {

    Param(
        [Parameter(ValueFromPipeline=$true)]
        $ComputerName,
        [Parameter(Mandatory=$true)]
        $ManagementGroupName,
        [Parameter(Mandatory=$true)]
        $ManagementServer,
        $ManagementServerPort = "5723",
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        #Test for Install
        $SCOMVersion = (Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\Microsoft Operations Manager\3.0\setup" -ErrorAction SilentlyContinue).AgentVersion
        if ($SCOMVersion){
        
            #Make change
            try {
                $Agent = New-Object -ComObject AgentConfigManager.MgmtSvcCfg
                $Agent.AddManagementGroup("$using:ManagementGroupName","$using:ManagementServer", "$using:ManagementServerPort")
            }
            catch{
                Write-error $_.Exception.Message
            }
            
            #Restart Service
            Restart-Service healthservice
            
            #============================= RETURN New Settings ==========================

            # Get New Agent Settings to return
            
                $Agent = New-Object -ComObject AgentConfigManager.MgmtSvcCfg
                $ServiceStatus = (Get-Service HealthService).Status.ToString()
                $ManagementGroupInfoRaw = $agent.GetManagementGroups()
                $ADIntegrationEnabled = try{$agent.GetActiveDirectoryIntegrationEnabled()}catch{try{$agent.ActiveDirectoryIntegrationEnabled()}catch{}}
                $LocalCollectionEnabled = try{$agent.GetLocalCollectionEnabled()}catch{try{$agent.LocalCollectionEnabled()}catch{}}
                $proxyURL = try{$agent.proxyURL}catch{}
                $proxyUsername = try{$agent.proxyUsername}catch{}
                #iterate through management group info can be mutli value, especicompany during migration
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
        }

        $object = [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            SCOMVersion = $SCOMVersion
            ServiceStatus = $ServiceStatus
            ADIntegrationEnabled = $ADIntegrationEnabled
            LocalCollectionEnabled = $LocalCollectionEnabled
            ManagementGroupInfo = $ManagementGroupInfo
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
