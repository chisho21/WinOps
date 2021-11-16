function Get-List {

	Write-Host "Paste your list below with each item on it's own line"
	$data = @(While($l=(Read-Host).Trim()){$l}) 
	$global:list = $data -split '\r\n' | ForEach-Object { $_.trim() | Where-object {$_ -ne $null} }
	$count = $global:list.count 
	Write-Host "$count items have been added to variable $ list"
    
}
