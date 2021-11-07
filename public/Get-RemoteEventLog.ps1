function Get-RemoteEventLog {
    Param (
        $ComputerName,
        [ValidateSet("System","Application","Security")]
        $LogName = "System",
        $Newest = 1000,
        $Source,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        $params = @{
            LogName = $using:LogName
            Newest = $using:Newest
        }
        if ($using:Source){
            $params.Add("Source",$using:Source)
        }
        
        Get-EventLog @params
    }#end scriptblock
	
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
