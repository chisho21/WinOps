function Get-LocalUserRightsAssignment {

    [CmdletBinding()]
    param(
        [string[]]
        $ComputerName,
        [Pscredential]
        $Credential
    )

    $scriptblock = {
        $data = Get-CIMINstance RSOP_UserPrivilegeRight -Namespace root\rsop\computer
        foreach ($d in $data){
        $resolved =  switch ($d.UserRight){
                'SeTrustedCredManAccessPrivilege' {'Access Credential Manager as a trusted caller' ; break } 
                'SeNetworkLogonRight' {'Access this computer from the network' ; break } 
                'SeTcbPrivilege' {'Act as part of the operating system' ; break } 
                'SeMachineAccountPrivilege' {'Add workstations to domain' ; break } 
                'SeIncreaseQuotaPrivilege' {'Adjust memory quotas for a process' ; break } 
                'SeInteractiveLogonRight' {'Allow log on locally' ; break } 
                'SeRemoteInteractiveLogonRight' {'Allow log on through Remote Desktop Services' ; break } 
                'SeBackupPrivilege' {'Back up files and directories' ; break } 
                'SeChangeNotifyPrivilege' {'Bypass traverse checking' ; break } 
                'SeSystemtimePrivilege' {'Change the system time' ; break } 
                'SeTimeZonePrivilege' {'Change the time zone' ; break } 
                'SeCreatePagefilePrivilege' {'Create a pagefile' ; break } 
                'SeCreateTokenPrivilege' {'Create a token object' ; break } 
                'SeCreateGlobalPrivilege' {'Create global objects' ; break } 
                'SeCreatePermanentPrivilege' {'Create permanent shared objects' ; break } 
                'SeCreateSymbolicLinkPrivilege' {'Create symbolic links' ; break } 
                'SeDebugPrivilege' {'Debug programs' ; break } 
                'SeDenyNetworkLogonRight' {'Deny access to this computer from the network' ; break } 
                'SeDenyBatchLogonRight' {'Deny log on as a batch job' ; break } 
                'SeDenyServiceLogonRight' {'Deny log on as a service' ; break } 
                'SeDenyInteractiveLogonRight' {'Deny log on locally' ; break } 
                'SeDenyRemoteInteractiveLogonRight' {'Deny log on through Remote Desktop Services' ; break } 
                'SeEnableDelegationPrivilege' {'Enable computer and user accounts to be trusted for delegation' ; break } 
                'SeRemoteShutdownPrivilege' {'Force shutdown from a remote system' ; break } 
                'SeAuditPrivilege' {'Generate security audits' ; break } 
                'SeImpersonatePrivilege' {'Impersonate a client after authentication' ; break } 
                'SeIncreaseWorkingSetPrivilege' {'Increase a process working set' ; break } 
                'SeIncreaseBasePriorityPrivilege' {'Increase scheduling priority' ; break } 
                'SeLoadDriverPrivilege' {'Load and unload device drivers' ; break } 
                'SeLockMemoryPrivilege' {'Lock pages in memory' ; break } 
                'SeBatchLogonRight' {'Log on as a batch job' ; break } 
                'SeServiceLogonRight' {'Log on as a service' ; break } 
                'SeSecurityPrivilege' {'Manage auditing and security log' ; break } 
                'SeRelabelPrivilege' {'Modify an object label' ; break } 
                'SeSystemEnvironmentPrivilege' {'Modify firmware environment values' ; break } 
                'SeManageVolumePrivilege' {'Perform volume maintenance tasks' ; break } 
                'SeProfileSingleProcessPrivilege' {'Profile single process' ; break } 
                'SeSystemProfilePrivilege' {'Profile system performance' ; break } 
                'SeUndockPrivilege' {'Remove computer from docking station' ; break } 
                'SeAssignPrimaryTokenPrivilege' {'Replace a process level token' ; break } 
                'SeRestorePrivilege' {'Restore files and directories' ; break } 
                'SeShutdownPrivilege' {'Shut down the system' ; break } 
                'SeSyncAgentPrivilege' {'Synchronize directory service data' ; break } 
                'SeTakeOwnershipPrivilege' {'Take ownership of files or other objects' ; break } 
            }
            if ($d.AccountList){
                foreach ($u in $d.AccountList){
                    [PSCustomObject]@{
                        ComputerName = $env:COMPUTERNAME
                        UserRight = $d.UserRight
                        Account = $u
                        RightDescription = $resolved
                    }
                }  
            }
            else {
                [PSCustomObject]@{
                    ComputerName = $env:COMPUTERNAME
                    UserRight = $d.UserRight
                    Account = "-"
                    RightDescription = $resolved
                }
            }
        }
    }
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
    Invoke-Command @params | select-object ComputerName,UserRight,Account,RightDescription -unique  

}
