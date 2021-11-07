function Install-SCCMApplications {
    Param (
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock1 = {
        #Gets list of Installed Apps
		$OS = (Get-CimInstance win32_operatingsystem).Caption
		$lastbootup = (Get-CimInstance -ClassName win32_OperatingSystem).lastbootuptime
        $applications = Get-CimInstance -Namespace "Root\ccm\ClientSDK" -Query "SELECT * FROM CCM_application" -ErrorAction Stop
    
        foreach($application in $applications)
        {
            foreach($EvaluationState in $($XmlEvaluationStates.states.option))
            {
                if($EvaluationState.value -eq $application.EvaluationState)
                {
                    $EvaluationStateProp=$EvaluationState.state
                }
            } 
            $props = [ordered]@{ 
                ComputerName = $env:ComputerName;
				Name = $application.Name;   
                InstallState = $application.InstallState; 
                ResolvedState = $application.ResolvedState;
                EvaluationState = $EvaluationStateProp;
				PercentComplete = $application.PercentComplete;
                ErrorCode = $application.ErrorCode;
                ApplicabilityState = $application.ApplicabilityState;
                LastEvalTime = $application.LastEvalTime; 
                LastInstallTime = $application.LastInstallTime; 
				LastReboot = $lastbootup
				OS = $os;
                Id = $application.Id;                
            } 
            New-Object -property $props -TypeName psobject
        }
    }# end script block

$scriptblock2 = {
	#Installs Apps	
    $id = $using:appid
    Write-Host "[ $env:COMPUTERNAME ] - Installing app id: $id" -foregroundcolor Yellow
    [System.Management.ManagementObject[]] $a = Get-CimInstance -query "SELECT * FROM CCM_Application WHERE Id like '$Id'" -namespace "ROOT\ccm\ClientSDK" -ErrorAction Stop
        $RELPATH = $a.__RELPATH -split ","
        if($RELPATH[1].Contains("TRUE"))
        {
            $IsMachineTarget = $true
        }
        else
        {
            $IsMachineTarget = $false
        }
        $revision = $RELPATH[2].Substring(10)
        $revision = $revision.Substring(0,$revision.Length-1)
        ([wmiclass]'ROOT\ccm\ClientSdk:CCM_Application').Install($Id, $revision, $IsMachineTarget, 0, 'Normal', $False)
    }# end script block
    
    $params = @{}
    if ($ComputerName){
		$params['ComputerName'] = $ComputerName
	}
	if ($Credential){
		$params['Credential'] = $Credential
	}
    

    $installs = Invoke-Command @params-ScriptBlock $scriptblock1 | Out-GridView -Title "Select Application you'd like to install and press 'OK'" -PassThru

    if ($installs){
    
        foreach ($install in $installs){
            
            $appid = $install.id
            $c = $install.computername
            $Computer = $ComputerName | Where-Object {$_ -match $c}

            Invoke-Command @params -Computer $Computer -ScriptBlock $scriptblock2
        }

    }# end if
    else{
        Write-Host "No apps selected, exiting now..." -ForegroundColor Yellow
    }#end else
      
}
