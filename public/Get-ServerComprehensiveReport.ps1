function Get-ServerComprehensiveReport {
    [CmdletBinding()]
    ##Retrieve all relavent server data and put into an excel sheet for multiple servers.
    Param (
        $ComputerName,
        $OutputPath,
        [System.Management.Automation.PSCredential]
        $Credential
    )
    ##Import required module and error out if not present
    Import-Module ImprotExcel -ErrorAction Stop

    $total = 7
    $count = 0
    ## Gather all the info
    $count ++
    Write-Host "[Report] - Gathering Systeminfo ($count of $total)" -foregroundcolor yellow
    $Systeminfo = Get-SystemInfo $ComputerName -Credential $Credential

    $count ++
    Write-Host "[Report] - Gathering Hotfixes ($count of $total)" -foregroundcolor yellow
    $Hotfix = Invoke-Command $ComputerName -Credential $Credential {Get-Hotfix}
    
    $count ++
    Write-Host "[Report] - Gathering Netstat output ($count of $total)" -foregroundcolor yellow
    $NetStat = Get-NetStat $ComputerName -Credential $Credential
    
    $count ++
    Write-Host "[Report] - Gathering SCCM Patching Info ($count of $total)" -foregroundcolor yellow
    $sccmpatch = Get-SCCMPatchList $ComputerName
    
    $count ++
    Write-Host "[Report] - Gathering Service Info ($count of $total)" -foregroundcolor yellow
    $Services = Get-ServiceImproved $ComputerName -Credential $Credential
    
    $count ++
    Write-Host "[Report] - Gathering Scheduled Tasks ($count of $total)" -foregroundcolor yellow
    $Schdtsk = Get-ScheduledTaskImproved $ComputerName -Credential $Credential
    
    $count ++
    Write-Host "[Report] - Gathering Installed Programs ($count of $total)" -foregroundcolor yellow
    $Progs = Get-InstalledPrograms $ComputerName -Credential $Credential
    
    ## Smash into 1 Excel sheet with tabs
    if (!$OutputPath){
        $date = Get-date -Format yyyyMMdd-mmss
        $OutputPath = "$env:TEMP\$date" + "_AdHocServerReport.xlsx"
    }
    
    $count = 0

    $count ++
    Write-Host "[Report] - Exporting Systeminfo ($count of $total)" -foregroundcolor cyan
    $Systeminfo | Export-Excel -Path $OutputPath -TableName SystemInfo -worksheetname Systeminfo -autosize -FreezeTopRowFirstColumn
    
    $count ++
    Write-Host "[Report] - Exporting NetStat  ($count of $total)" -foregroundcolor cyan
    $NetStat | Export-Excel -Path $OutputPath -TableName NetStat -worksheetname NetStat -autosize -FreezeTopRowFirstColumn
    
    $count ++
    Write-Host "[Report] - Exporting SchedTask ($count of $total)" -foregroundcolor cyan
    $Schdtsk | Export-Excel -Path $OutputPath -TableName SchedTask  -worksheetname SchedTask -autosize -FreezeTopRowFirstColumn
    
    $count ++
    Write-Host "[Report] - Exporting Services ($count of $total)" -foregroundcolor cyan
    $Services | Export-Excel -Path $OutputPath -TableName Services -worksheetname Services -autosize -FreezeTopRowFirstColumn
    
    $count ++
    Write-Host "[Report] - Exporting SCCMPatchList ($count of $total)" -foregroundcolor cyan
    $sccmpatch | Export-Excel -Path $OutputPath -TableName SCCMPatchList -worksheetname SCCMPatchList -autosize -FreezeTopRowFirstColumn
    
    $count ++
    Write-Host "[Report] - Exporting Programs ($count of $total)" -foregroundcolor cyan
    $Progs | Export-Excel -Path $OutputPath -TableName Programs -worksheetname Programs -autosize -FreezeTopRowFirstColumn
    
    $count ++
    Write-Host "[Report] - Exporting Hotfixes ($count of $total)" -foregroundcolor cyan
    $Hotfix | Export-Excel -Path $OutputPath -TableName Hotfixes -worksheetname Hotfixes -autosize -FreezeTopRowFirstColumn

    Write-Host "[Report] - Launching File $outputpath" -foregroundcolor green
    Invoke-Item $OutputPath
}# end function