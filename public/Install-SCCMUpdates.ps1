function Install-SCCMUpdates {

	Param (
		[Parameter(Mandatory=$true,
						Position=0)]
		$ComputerName,
		[System.Management.Automation.PSCredential]
		$Credential
	
	)

    $scriptblock = {
		function Start-SCClientInstallUpdate {
			param(
			[Parameter(Mandatory=$false)]
			[string[]] $ComputerName="localhost",
			[Parameter(Mandatory=$false)]
			[System.Management.Automation.PSCredential] 
			[System.Management.Automation.Credential()]
			$Credential,
			[Parameter(Mandatory=$false)]
			[string] $UpdateID="%"
			) 

			if($(Test-Connection -ComputerName $ComputerName -Count 1 -BufferSize 10 -Quiet))
			{
				if($ComputerName -eq "localhost")
				{
					[System.Management.ManagementObject[]] $a = Get-CimInstance -query "SELECT * FROM CCM_SoftwareUpdate WHERE UpdateID like '$UpdateID'" -namespace "ROOT\ccm\ClientSDK" -ErrorAction Stop
					([wmiclass]'ROOT\ccm\ClientSDK:CCM_SoftwareUpdatesManager').InstallUpdates($a)
				}
				else
				{
					if($Credential)
					{
						Invoke-Command $ComputerName -ScriptBlock{
							param ([string] $arg1 = $UpdateID)
							[System.Management.ManagementObject[]] $a = Get-CimInstance -query "SELECT * FROM CCM_SoftwareUpdate WHERE UpdateID like '$arg1'" -namespace "ROOT\ccm\ClientSDK" -ErrorAction Stop
							([wmiclass]'ROOT\ccm\ClientSDK:CCM_SoftwareUpdatesManager').InstallUpdates($a)
						} -ArgumentList $UpdateID -Credential $Credential
					}
					else
					{
						Invoke-Command $ComputerName -ScriptBlock{
							param ([string] $arg1 = $UpdateID)
							[System.Management.ManagementObject[]] $a = Get-CimInstance -query "SELECT * FROM CCM_SoftwareUpdate WHERE UpdateID like '$arg1'" -namespace "ROOT\ccm\ClientSDK" -ErrorAction Stop
							([wmiclass]'ROOT\ccm\ClientSDK:CCM_SoftwareUpdatesManager').InstallUpdates($a)
						} -ArgumentList $UpdateID
					}
				}
			}	
			else
			{
				Write-Error "The computer you try to manage is offline." -Category ConnectionError
			}
		}#end function
		Start-SCClientInstallUpdate
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
