function Get-Uptime {
 
    [CmdletBinding()]
    Param (
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential         
    )

    $scriptblock = {

        $System = Get-CimInstance -Class Win32_ComputerSystem 
        $OS = Get-CimInstance -Class Win32_OperatingSystem 
        $Uptime = New-TimeSpan $OS.LastBootUpTime $OS.LocalDateTime -ErrorAction SilentlyContinue
       
        [pscustomobject] @{
            ComputerName = $system.name
            Uptime = "{0} days {1} hours {2} minutes" -f $Uptime.Days, $Uptime.Hours, $Uptime.Minutes
            LastReboot = $OS.LastBootUpTime
        }

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