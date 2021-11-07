function Get-List {

     <#
	.Synopsis
	   Allows user to paste an ad-hoc list into PowerShell and store as $list.
	.DESCRIPTION
	   Shell prompts user for list. Each line is added to object $list as a seperate item. This is very useful when dealing with a non-standard list of items/servers.
	.SERVICENOW_REF
		N/A
	#>

	Write-Host "Paste your list below with each item on it's own line"
	$data = @(While($l=(Read-Host).Trim()){$l}) 
	$global:list = $data -split '\r\n' | ForEach-Object { $_.trim() | Where-object {$_ -ne $null} }
	$count = $global:list.count 
	Write-Host "$count items have been added to variable $ list"
    
}
