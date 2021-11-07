function Get-SCCMApplicationStatus {

    Param (
        [Parameter(Mandatory=$true,
                        Position=0)]
        $ComputerName,
        [string]
        $SearchString,
        [Switch]
        $Watch,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
		$OS = (Get-CimInstance win32_operatingsystem).Caption
		$lastbootup = (Get-CimInstance -ClassName win32_OperatingSystem).lastbootuptime
        $applications = Get-CimInstance -Namespace "Root\ccm\ClientSDK" -Query "SELECT * FROM CCM_application" -ErrorAction Stop
        $finaltable = @()
        foreach($application in $applications)
        {
            switch($application.EnforcePreference)
            {
                0{$EnforcePreferenceProp="Immediate"}
                1{$EnforcePreferenceProp="NonBusinessHours"}
                2{$EnforcePreferenceProp="AdminSchedule"}
                default{$EnforcePreferenceProp="Unknown"}
            }
            switch ($application.EvaluationState){
                0	{$eval = "No state information is available."}
                1	{$eval = "Application is enforced to desired/resolved state."}
                2	{$eval = "Application is not required on the client."}
                3	{$eval = "Application is available for enforcement (install or uninstall based on resolved state). Content may/may not have been downloaded."}
                4	{$eval = "Application last failed to enforce (install/uninstall)."}
                5	{$eval = "Application is currently waiting for content download to complete."}
                6	{$eval = "Application is currently waiting for content download to complete."}
                7	{$eval = "Application is currently waiting for its dependencies to download."}
                8	{$eval = "Application is currently waiting for a service (maintenance) window."}
                9	{$eval = "Application is currently waiting for a previously pending reboot."}
                10	{$eval = "Application is currently waiting for serialized enforcement."}
                11	{$eval = "Application is currently enforcing dependencies."}
                12	{$eval = "Application is currently enforcing."}
                13	{$eval = "Application install/uninstall enforced and soft reboot is pending."}
                14	{$eval = "Application installed/uninstalled and hard reboot is pending."}
                15	{$eval = "Update is available but pending installation."}
                16	{$eval = "Application failed to evaluate."}
                17	{$eval = "Application is currently waiting for an active user session to enforce."}
                18	{$eval = "Application is currently waiting for all users to logoff."}
                19	{$eval = "Application is currently waiting for a user logon."}
                20	{$eval = "Application in progress, waiting for retry."}
                21	{$eval = "Application is waiting for presentation mode to be switched off."}
                22	{$eval = "Application is pre-downloading content (downloading outside of install job)."}
                23	{$eval = "Application is pre-downloading dependent content (downloading outside of install job)."}
                24	{$eval = "Application download failed (downloading during install job)."}
                25	{$eval = "Application pre-downloading failed (downloading outside of install job)."}
                26	{$eval = "Download success (downloading during install job)."}
                27	{$eval = "Post-enforce evaluation."}
                28	{$eval = "Waiting for network connectivity."} 
            }
            $props = [PSCustomObject]@{
                ComputerName = $env:ComputerName;
				Name = $application.Name;   
                InstallState = $application.InstallState;
                ResolvedState = $application.ResolvedState;
                EvaluationState = $eval;
                Enforcement = $EnforcePreferenceProp
				PercentComplete = $application.PercentComplete;
                ErrorCode = $application.ErrorCode;
                ApplicabilityState = $application.ApplicabilityState;
                LastEvalTime = $application.LastEvalTime; 
                LastInstallTime = $application.LastInstallTime; 
				LastReboot = $lastbootup
				OS = $os;
                Id = $application.Id;                
            } 
            $finaltable += $props
        }

        if ($using:searchstring){
            $finaltable = $finaltable |Where-Object {$_.Name -like $using:searchstring}
            
        }

        if (!$finaltable){
            $finaltable = [PSCustomObject]@{
                ComputerName = "$env:ComputerName;"
				Name = "-"  
                InstallState = "-"  
                ResolvedState = "-"  
                EvaluationState = "-"  
				PercentComplete = "-"  
                ErrorCode = "-"  
                ApplicabilityState = "-"  
                LastEvalTime = "-"   
                LastInstallTime = "-"   
				LastReboot = $lastbootup
				OS = $os;
                Id = "-"                 
            } 
        }
        return $finaltable
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

    if ($Watch){
        while(1){
            $date = Get-Date -format "dddd MM/dd/yyyy HH:mm" 
            Invoke-Command @params | 
                    Sort-Object Installstate | 
                        Out-GridView -Title "$date - Close Grid View to Refresh" -PassThru
        }#end while

    }
    else {
        Invoke-Command @params
    }
    
}
