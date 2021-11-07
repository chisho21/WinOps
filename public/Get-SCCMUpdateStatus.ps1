function Get-SCCMUpdateStatus {
    Param (
        $ComputerName,
        [Parameter()]
        [Switch]
        $Watch,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        $updatetable = @()
            $Updates =  Get-CimInstance -Namespace "root\ccm\clientsdk" -Class CCM_SoftwareUpdate 
            If(!$Updates){
                $Updateinfo = New-Object PSObject -Property ([ordered]@{      
                            ComputerName = $env:ComputerName
                            State             = " - "
                            ArticleId         = " - "
                            Publisher         = " - "
                            Software          = " - "
                            Description       = " - "
                            
                    })
                    $updatetable += $Updateinfo
                    return $updatetable
            }
            Else{
                Foreach ($App in $Updates){
      
                    $EvState = Switch ( $App.EvaluationState  ) {
                            '0'  { "None" } 
                            '1'  { "Available" } 
                            '2'  { "Submitted" } 
                            '3'  { "Detecting" } 
                            '4'  { "PreDownload" } 
                            '5'  { "Downloading" } 
                            '6'  { "WaitInstall" } 
                            '7'  { "Installing" } 
                            '8'  { "PendingSoftReboot" } 
                            '9'  { "PendingHardReboot" } 
                            '10' { "WaitReboot" } 
                            '11' { "Verifying" } 
                            '12' { "InstallComplete" } 
                            '13' { "Error" } 
                            '14' { "WaitServiceWindow" } 
                            '15' { "WaitUserLogon" } 
                            '16' { "WaitUserLogoff" } 
                            '17' { "WaitJobUserLogon" } 
                            '18' { "WaitUserReconnect" } 
                            '19' { "PendingUserLogoff" } 
                            '20' { "PendingUpdate" } 
                            '21' { "WaitingRetry" } 
                            '22' { "WaitPresModeOff" } 
                            '23' { "WaitForOrchestration" } 
      
      
                            DEFAULT { "Unknown" }
                    }
      
                    $Updateinfo = New-Object PSObject -Property ([ordered]@{      
                            ComputerName = $env:ComputerName
                            State             = $EvState  
                            PercentComplete   = $app.PercentComplete
                            ArticleId         = $App.ArticleID
                            Publisher         = $App.Publisher
                            Software          = $App.Name
                            Description       = $App.Description
                              
                    }) #end Object
                    $updatetable += $Updateinfo
                } #end foreach
                return $updatetable
            }#end else
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
                    Sort-Object state | 
                        Out-GridView -Title "$date - Close Grid View to Refresh" -PassThru
        }#end while

    }
    else {
        Invoke-Command @params
    }
    
    
}
