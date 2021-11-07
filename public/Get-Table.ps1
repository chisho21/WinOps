function Get-Table {

    [CmdletBinding()]
    param(
        [Parameter(Position = 0)]
        [string]
        $Delimiter = "`t"
    )
	Write-Host "Paste your Excel textblock below and hit ENTER"
	$data = @(While($l=(Read-Host).Trim()){$l}) 
    try{
        $Global:table = Convertfrom-CSV $data -Delimiter $Delimiter
    }
    catch{
        Write-Warning "(Bad Delimeter I think?)"
        return
    }
    $count = $Global:table.count
	Write-Host "$count items have been added to variable $`table"

}
