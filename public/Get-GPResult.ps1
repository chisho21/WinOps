function Get-GPResult {

    param (
        [Parameter( ValueFromPipeline=$true,
            Position=0)]
        [string[]]
        $ComputerName,
        [string]
        [ValidateSet('Html','Xml')]
        $ReportType = 'Html',
        $OutPath,
        [System.Management.Automation.PSCredential]
        $Credential
    )
    Begin{
        
    }
    process {

        $date = Get-Date -Format yyyyMMdd_hhmmss

        $scriptblock = {
            $date = $using:date
            $format = $using:ReportType
            $path = $env:Temp + "\$date`_$env:computername`_GPRESULTReport.$format"
            $userlist = (Get-ChildItem "C:\Users" | Sort-Object LastWriteTime -Descending).name
            $formatswitch = switch ($format){
                'Xml' {'/X'}
                'Html' {'/H'}
            }
                foreach ($u in $userlist) { 
                    $user = "$u"
                    Write-Host "[ $env:ComputerName ] - Exporting GPRESULT Report to $path. Using user $user. Please Wait..."

                    $null = gpresult.exe $formatswitch $path /SCOPE Computer /USER $user /F
                    if (Test-Path $path){
                        $status = "Success"
                        break
                    }
                    else {
                        $status = "Failed"
                    }
                }

                [PSCustomObject]@{
                    Computer = $env:computername
                    Path = $path
                    Status = $status
                }

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

        $result = Invoke-Command @params
        $results = $result | Where-object {$_.path -and $_.status -eq "Success"}
        foreach ($res in $results){
            $pssession = New-PSSession -ComputerName $res.pscomputername -Credential $Credential
            if (!$outpath){
                $path = $env:Temp + "\$date`_$($res.pscomputername)`_GPRESULTReport.$ReportType"
                Copy-Item -Path $res.path -Destination $path -FromSession $pssession
                Invoke-Item $path
            }
            else {
                Copy-Item -Path $res.path -Destination $outpath -FromSession $pssession -Force
            }
            $pssession | Remove-pssession -Confirm:$false
        }
    }

}
