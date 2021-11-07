function Get-EMCPowerPathInfo {
    <#
	.Synopsis
	   Get EMC PowerPath Disk info
	.DESCRIPTION
	   Script Retrieves Disk names, paths, etc. as provided by 'powermt display paths'
	.EXAMPLE
       Export List of servers EMC info 
        Get-EMCPowerPathInfo -ComputerName $list -Credential $admincred | Export-Excel
    .EXAMPLE
       Export List of servers EMC info with full details
        Get-EMCPowerPathInfo -ComputerName $list -Credential $admincred -Detailed | Export-Excel
	#>
    Param (
        [string[]]
        $ComputerName,
        [Switch]
        $Detailed,
        [System.Management.Automation.PSCredential]
        $Credential
    )
        

    
    $scriptblocksimple = {
        $Outputs = powermt display paths
    
        # Create Hash Table
        $Properties = @()
    
        foreach ($Output in $Outputs){
            # Clear Variables
            
            if ($Output -ne ""){
                #Write-Host "working on $output"
                
                if ($Output -match 'Symmetrix logical device count=(?<Name>\d+)'){ $SymetrixDevCount = $Matches["Name"] }
                elseif ($Output -like "*port*path*") { 
                    $Diskinfo = $output -split " " | Where-Object {$_ -ne ""}
                    $object = [pscustomobject]@{
                        Computer = $env:COMPUTERNAME
                        SymetrixDevCount = $SymetrixDevCount
                        Port = $Diskinfo[0]
                        HW_Path = $Diskinfo[1]
                        StorageID = $Diskinfo[2]
                        Stor_interf = $Diskinfo[3] + "--" + $Diskinfo[4]
                        IOPathTotal = $Diskinfo[5]
                        IOPathDead = $Diskinfo[6]   
                    }#end object
                    $Properties += $object
                    }#end elseif port*path

            }#end if $output
            else{
                Write-Verbose "Skipping line: $Output"
            }#end else
        }#end foreach $output
        return $properties
    }# end script block

    
    $scriptblockdetailed = {
        $Outputs = powermt display dev=all
 
		# Create Hash Table
		$Properties = @()
 
		foreach ($Output in $Outputs){
			# Clear Variables
			
			if ($Output -ne ""){
				#Write-Host "working on $output"
                
                if ($Output -match 'Pseudo name=harddisk(?<Name>\d+)'){ $PsuedoName = "harddisk" + $Matches["Name"] }
                elseif ($Output -match 'Logical device ID=(?<ID>\w+)') { $LogicalDeviceID = $Matches["ID"] }
                elseif ($Output -like "state*policy*queued*") { 
                    $data = ($output -split ";").trim() | ConvertFrom-StringData
                    $state = $data.state
                    $policy = $data.policy
                    $queudIOs = $data.'queued-IOs'
                     }#end elseif state*policy
                elseif ($Output -like "*port*path*") { 
                    $Diskinfo = $output -split " " | Where-Object {$_ -ne ""}
                    $object = [pscustomobject]@{
                        Computer = $env:COMPUTERNAME
                        PseudoName = $PsuedoName
                        LogicalDevID = $LogicalDeviceID
                        State = $State
                        Policy = $policy
                        QueuedIOs = $queudIOs
                        Port = $Diskinfo[0]
                        HW_Path = $Diskinfo[1]
                        IO_Paths = $Diskinfo[2]
                        Stor_interf = $Diskinfo[3] + " " + $Diskinfo[4]
                        IOPathMode = $Diskinfo[5]
                        IOPathState = $Diskinfo[6]
                        QIOs = $Diskinfo[7]
                        Err = $Diskinfo[8]

                    }#end object
                    $Properties += $object
                 }#end elseif port*path

            }#end if $output
			else{
				Write-Verbose "Blank Line"
            }#end else
        }#end foreach $output
        return $properties
    }# end script block
    
    ## Choose Scriptblock
    if ($Detailed){
        $scriptblock = $scriptblockdetailed
    }
    else{
        $scriptblock = $scriptblocksimple
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
	Invoke-Command @params

    
    
}
