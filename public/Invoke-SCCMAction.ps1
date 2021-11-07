function Invoke-SCCMAction {

	Param (
		$ComputerName,
		[Parameter(Mandatory=$true,
						Position=1)]
		[ValidateSet('MachinePolicyEval','SoftwareUpdateScan','SoftwareUpdateDeploymentEval','ApplicationDeploymentEval','HardwareInventory')]
		$Action,
		[System.Management.Automation.PSCredential]
		$Credential
	
	)
	
    $scriptblock = {

    switch ($using:Action)
                {
                    
                    'MachinePolicyEval' {$actionid = '{00000000-0000-0000-0000-000000000021}'}
                    'SoftwareUpdateScan' {$actionid = '{00000000-0000-0000-0000-000000000113}'}
                    'SoftwareUpdateDeploymentEval' {$actionid = '{00000000-0000-0000-0000-000000000108}'}
                    'ApplicationDeploymentEval' {$actionid = '{00000000-0000-0000-0000-000000000121}'}
                    'HardwareInventory' {$actionid = '{00000000-0000-0000-0000-000000000001}'}
                    
                }
       Write-Host "$env:computername :: Triggering $using:Action" 
       Invoke-WmiMethod -Namespace root\ccm -Class sms_client -Name TriggerSchedule -ArgumentList "$actionid" -ErrorAction Stop
        
        
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
