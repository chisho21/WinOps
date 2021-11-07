function Get-ScheduledTaskImproved {
 
    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        [switch]
        $RootOnly,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    
    $scriptblock = {
        $data = schtasks.exe /query /V /FO CSV | ConvertFrom-Csv | Where-Object { $_.TaskName -ne "TaskName"}

        if ($using:RootOnly){
            $data = $data | Where-Object {$_.TaskName -notlike "\*\*"}
        }

        return $data
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
