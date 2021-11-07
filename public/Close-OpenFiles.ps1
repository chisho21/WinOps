function Close-OpenFiles {
    Param (
            [Parameter(Mandatory=$true,
                           ValueFromPipelineByPropertyName=$true,
                           Position=0)]
            [string[]]
            $ComputerName,
            [Parameter(Position=1)]
            [string[]]
            $SearchString,
            [switch]
            $Force,
            [switch]
            $SelectAll,
            [System.Management.Automation.PSCredential]
            $Credential
            
        )
        
        ## Get Open Files and place to variable object
            Write-Host "Getting List of Open Files on $computername" -ForegroundColor Yellow
            $openfiles = invoke-command -ComputerName $computername -Credential $Credential {
                if ($using:Searchstring){
                    Get-SmbOpenfile | Where-Object {$_.path -like $using:Searchstring}
                }
                else {
                    Get-SmbOpenfile
                }
            }
                
        ## Select files via OGV
            if ($SelectAll){
                $filestoclose = $openfiles
            }
            else {
                Write-Host "Retrieved $($openfiles.count) files from $computername" -ForegroundColor Yellow
                Write-Host "Please select files to close in Out-GridView" -ForegroundColor Cyan
                $filestoclose = $openfiles | Out-GridView -PassThru -Title "Select Files to close" 
            }

        ## Close all selected Files
            #setup output table
            $table = @()
            if ($filestoclose){
                foreach ($file in $filestoclose){
                    if ($Force){
                        invoke-command -ComputerName $file.PsComputername -Credential $Credential {Close-SmbOpenFile -FileId $using:file.FileId -Confirm:$false }
                    }
                    else {
                        invoke-command -ComputerName $file.PsComputername -Credential $Credential {Close-SmbOpenFile -FileId $using:file.FileId }
                    }
                
                    $output = [PSCustomObject]@{
                        Server = $file.PsComputername
                        ClientUser = $file.ClientUserName
                        ClientComputer  = $file.ClientComputerName
                        Path = $file.Path
                    }
                    #add File Values
                    $table += $output
            
                }
                Write-Host "List of Closed Files - $computername"
                Write-Host "===================="
                $table | Format-Table
            }
            else {
                Write-Host "No files selected. Exiting script."
            }
        
        

}
