function Get-ServiceImproved {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true,
                        Position=0)]
        $ComputerName,
        $searchstring = "*",
        [System.Management.Automation.PSCredential]
        $Credential
        
    )
    
    $scriptblock = {
        $services = Get-CimInstance win32_service | Where-Object {$_.Name -like "$using:searchstring"} | 
            Select-Object -property Name,DisplayName,StartMode,State,@{ Name = "LogOnAs"; Expression ={$_.StartName}},Description,PathName,ProcessId | 
                Sort-Object StartMode
        return $services
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
