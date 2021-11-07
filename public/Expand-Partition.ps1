function Expand-Partition {
 
    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        $DriveLetter,
        [System.Management.Automation.PSCredential]
        $Credential
    )
        
    $scriptblock = {
        $driveletter = $using:driveletter
        if ($DriveLetter){
            foreach ($drive in $driveletter){
                try {
                    $maxsize = (Get-PartitionSupportedSize -DriveLetter $drive).sizemax
                    Write-Host "[ $env:COMPUTERNAME ] - Expanding $drive to $maxsize"
                    Resize-Partition -DriveLetter $drive -Size $maxsize
                }
                catch{
                    Write-Error "Error with Drive Letter $drive"
                }
            }
        }
        else{
            #Expand them ALL! (if they have a drive letter)
            $driveletter = (Get-Partition | Where-Object {$_.driveletter}).driveletter
            foreach ($drive in $driveletter) { 
                $maxsize = (Get-PartitionSupportedSize -DriveLetter $drive).sizemax
                Write-Host "[ $env:COMPUTERNAME ] - Expanding $drive to $maxsize"
                Resize-Partition -DriveLetter $drive -Size $maxsize
            
            }
        
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
