function Get-RemoteSession {
    [CmdletBinding()]
    Param (
        [string[]]  
        $ComputerName,
        $UserName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        Write-Verbose "$env:Computername - CONNECTED!"
        
        $Users = query user
        $Users = $Users | ForEach-Object {
            (($_.trim() -replace ">" -replace "(?m)^([A-Za-z0-9-._]{3,20})\s+(\d+\s+\w+)", '$1  none  $2' -replace "\s{2,}", "," -replace "none", $null))
        } | ConvertFrom-Csv
        return $users
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
