function Get-PartitionInfo {
    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        [string[]]
        $DriveLetter,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        $DriveLetter = $using:DriveLetter
        $partinfo = Get-Partition

        if ($DriveLetter){
            $partinfo = $partinfo | Where-object {$DriveLetter -contains $_.DriveLetter}
        }
        
        $partinfo | Select-Object disknumber,partitionnumber,driveletter,@{Name="SizeGB";Expression={$a = $_.size / 1GB; [math]::Round($a,2)}},type,OperationalStatus,@{Name="MaxSizeGB";Expression={if($_.driveletter){$a = (Get-PartitionSupportedSize -DriveLetter $_.driveletter).sizemax / 1GB; [math]::Round($a,2) }}},@{Name="FreeSpaceGB";Expression={if($_.driveletter){$a = (Get-Psdrive $_.driveletter).free / 1GB; [math]::Round($a,2)} }},DiskId,MbrType,GptType,isBoot

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
	Invoke-Command @params
    
    
}
