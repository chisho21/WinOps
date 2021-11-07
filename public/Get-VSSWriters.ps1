function Get-VSSWriters {
    Param (
        [string[]]
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )
        
    $scriptblock = {
        function Get-VSSWriter {    
            Param (
                [ValidateSet('Stable', 'Failed')]
                [String] 
                $Status
            ) #Param
    
            #Command to retrieve all writers, and split them into groups
            Write-Verbose "Retrieving VSS Writers"
            VSSAdmin list writers | 
            Select-String -Pattern 'Writer name:' -Context 0, 4 |
            ForEach-Object {
    
                #Removing clutter
                Write-Verbose "Removing clutter "
                $Name = $_.Line -replace "^(.*?): " -replace "'"
				$State = $_.Context.PostContext[2] -replace "^(.*?): "
                $LastError = $_.Context.PostContext[3] -replace "^(.*?): "
                $Id = $_.Context.PostContext[0] -replace "^(.*?): "
                $InstanceId = $_.Context.PostContext[1] -replace "^(.*?): "
                
    
                #Create object
                Write-Verbose "Creating object"
                foreach ($Prop in $_) {
                    $object = [pscustomobject]@{
                        ComputerName = $env:COMPUTERNAME
						Name       = $Name
						State      = $State
                        LastError  = $LastError
                        Id         = $Id
                        InstanceId = $InstanceId
                        
                    } 
                }#foreach  
    
                #Change output based on Status provided
                If ($PSBoundParameters.ContainsKey('Status')) {
                    Write-Verbose "Filtering out the results"
                    $object | Where-Object { $_.State -like "*$Status" }
                } #if
                else {
                    $object
                } #else
            }#foreach-object
        }#function
        Get-VSSWriter
    }#end Scriptblock
    
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
