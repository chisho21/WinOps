#Requires -Version 5.1
[cmdletbinding()]
param()

Write-Verbose $PSScriptRoot

Write-Verbose 'Import everything in sub folders folder'
foreach($Folder in @('public','private'))
{
    $Root = Join-Path -Path $PSScriptRoot -ChildPath $Folder
    if(Test-Path -Path $Root)
    {
        Write-Verbose "processing folder $Root"
        $Files = Get-ChildItem -Path $Root -Filter *.ps1 -Recurse

        # dot source each file
        $Files | Where-Object{ $_.name -NotLike '*.Testing.ps1'} | 
             ForEach-Object {Write-Verbose $_.basename; . $PSItem.FullName}
    }
}

Export-ModuleMember -Function (Get-ChildItem -Path "$PSScriptRoot\public\*.ps1").BaseName

