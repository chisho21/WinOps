function Get-DNSSettings {
    Param (
        [string[]]
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        $dns = Get-DnsclientServerAddress -AddressFamily ipv4 |Where-Object {$_.interfacealias -like "Ethernet*"}
        $table = @()

        foreach ($d in $dns){
            $object = $null
            $object = [pscustomobject] @{
                Computer = $env:COMPUTERNAME
                InterfaceAlias = $d.InterfaceAlias
                DNS1 = $d.ServerAddresses[0]
                DNS2 = $d.ServerAddresses[1]
                DNS3 = $d.ServerAddresses[2]
                }
            $table += $object
            
        }
        return $table
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
