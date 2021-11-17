function Get-InstalledPrograms {
    Param (
        $ComputerName,
        $searchstring,
        [System.Management.Automation.PSCredential]
        $Credential

    )
    
    $scriptblock = {

        $keypaths = "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*","HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*"
        $data = foreach ($path in $keypaths){Get-ItemProperty $path | 
                Where-Object {$_.Displayname} | Sort-Object DisplayName |
                        Select-Object @{N='Name';E={$_.DisplayName}}, @{N='Version';E={$_.DisplayVersion}}, Publisher, InstallDate,UninstallString,InstallLocation,InstallSource} 
        
        if ($using:searchstring){
            $data = $data | Where-Object {$_.Name -like "$using:searchstring"}
        }#end if
        
        if (!$data){
            $data = [pscustomobject]@{
                Name = "-"
                Version = "-"
                Publisher = "-"
                InstallDate = "-"
                UninstallString = "-"
                InstallLocation = "-"
                InstallSource = "-"
            }
        }#end if
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
