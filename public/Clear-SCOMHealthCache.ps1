function Clear-SCOMHealthCache {

    Param (
        [Parameter(ValueFromPipeline=$true)]
        $ComputerName,
        [System.Management.Automation.PSCredential]
        $Credential
    )

## Connect to the server

    $scriptblock = {
        ## Stop the Microsoft Monitoring Agent service
        $service = Get-Service -Name HealthService
        $oldfoldername = "Health Service State old"
        $agentpath = "C:\Program Files\Microsoft Monitoring Agent\Agent\"
        $healthpath = Join-Path $agentpath "Health Service State"
        $healthpathold = Join-Path $agentpath $oldfoldername
        $pathexists = $null
        Write-Host "[ $env:COMPUTERNAME ] 1. Stopping the Monitoring Agent service..." 
        Stop-Service $Service
        Write-Host "[ $env:COMPUTERNAME ] 2. Checking the Monitoring Agent service status:"
        Write-Host "[ $env:COMPUTERNAME ] Monitoring Agent service status: "-nonewline; Write-Host $Service.Status -Fore Red
        Start-Sleep -s 3 
        ## Rename "C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State" to "C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State.old"
        Write-Host "[ $env:COMPUTERNAME ] 3. Renaming the existing 'Health Service State' folder to 'Health Service State Old' "
        Rename-Item -Path $healthpath -NewName $oldfoldername -Force
        ## Start the Microsoft Monitoring Agent service
        Write-Host "[ $env:COMPUTERNAME ] 4. Starting the Monitoring Agent service..."
        Start-Service $Service
        Start-Sleep -s 3
        Write-Host "[ $env:COMPUTERNAME ] 5. Checking the Monitoring Agent service status:"
        Write-Host "[ $env:COMPUTERNAME ] Monitoring Agent service status: "-nonewline; Write-Host $Service.Status -Fore Green 
        ## Validate new "C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State" folder was created
        Write-Host "[ $env:COMPUTERNAME ] 6. Validating new Health Server State folder exists."
        $pathexists = Test-Path $healthpath
        if ($pathexists){
            ## Delete "C:\Program Files\Microsoft Monitoring Agent\Agent\Health Service State.old"
            Write-Host "[ $env:COMPUTERNAME ] 7. Removing the 'Health Service State Old' folder."
            Remove-Item -Path $healthpathold -Recurse -Force
            Write-Host "[ $env:COMPUTERNAME ] 8. Done!"
            }
        else {
            Write-Error "[ $env:COMPUTERNAME ] 7. New 'Health Service State' folder doesn't exist."
            Return    
            }
        } ## end script block

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
