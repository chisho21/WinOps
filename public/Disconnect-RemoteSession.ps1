function Disconnect-RemoteSession {
 
    Param (
        [string[]]
        $ComputerName,
        $UserName,
        [switch]
        $Force,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock1 = {
        Write-Host "$env:Computername - CONNECTED!" -ForegroundColor Green
        
        $Users = query user
        $Users = $Users | ForEach-Object {
            (($_.trim() -replace ">" -replace "(?m)^([A-Za-z0-9-._]{3,20})\s+(\d+\s+\w+)", '$1  none  $2' -replace "\s{2,}", "," -replace "none", $null))
        } | ConvertFrom-Csv
        return $users

    }# end script block

    $scriptblock2 = {
        Write-Host "$env:Computername - Logging off $using:user = Session# $using:id" -ForegroundColor Yellow
        logoff $using:id
    }# end script block
        
        $sessions = Invoke-Command -ComputerName $ComputerName -ScriptBlock $scriptblock1 -Credential $Credential

        if ($UserName){
            $closesessions = $sessions | Where-Object {$_.Username -eq $UserName}
        }
        else{
            $closesessions = $sessions | Out-GridView -PassThru -Title "Select Sessions you would like to Terminate."
        }
        

        if ($closesessions){
            if (!($Force)){
                $closesessions | select pscomputername,username,id,sessionname,state,idletime,'logon time' | Format-Table
                $confirm = Read-Host "Are you sure you want to close these sessions? (Y/N) (Blank=N)"
            }#end if    
            else{
                $confirm = "Y"
            }#end else
            if($confirm -match "Y"){
            foreach ($session in $closesessions){
                    $id = $null
                    $user = $null
                    $id = $session.id
                    $user = $session.username
                    Invoke-Command -ComputerName $session.pscomputername -ScriptBlock $scriptblock2 -Credential $Credential
                }#end foreach
            return $closesessions  
            }#end if $confirm
            else {
                Write-Host "Disconnect Sessions Cancelled" -ForegroundColor Yellow
            } 
        }#end if $closesessions
        else {
            Write-Verbose "No sessions selected, exiting now"
            break
        }
    
    
}
