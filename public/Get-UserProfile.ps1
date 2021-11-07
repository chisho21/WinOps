function Get-UserProfile {
    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        [int]
        $DaysInactive,
        $UserName,
        [switch]
        $IncludeSpecial,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        $DaysInactive = $using:DaysInactive
        $UserName = $using:UserName
        $IncludeSpecial = $using:IncludeSpecial
        if ($DaysInactive){
            if ($IncludeSpecial){
                $data = Get-CimInstance -class Win32_UserProfile | Where-Object { (!$_.Loaded) -and ($_.ConvertToDateTime($_.LastUseTime) -lt (Get-Date).AddDays(-$DaysInactive))}
            }
            else {
                $data = Get-CimInstance -class Win32_UserProfile | Where-Object {(!$_.Special) -and (!$_.Loaded) -and ($_.ConvertToDateTime($_.LastUseTime) -lt (Get-Date).AddDays(-$DaysInactive))}
            }
        }
        elseif ($username){
            $data = Get-CimInstance -class Win32_UserProfile
        }
        elseif ($IncludeSpecial){
            $data = Get-CimInstance -class Win32_UserProfile
        }
        else {
           $data = Get-CimInstance -class Win32_UserProfile | Where-Object {(!$_.Special)}
        }
        $return = @()
        foreach ($d in $data){
            $object = $null
            $name = if($d.localpath){($d.LocalPath -split "\\")[-1]}else{"UnresolvedSID"}
            $date = if($d.lastusetime){$d.ConvertToDateTime($d.LastUseTime)}else{"-"}
            if(Test-Path $d.localpath){
                $props = Get-Item $d.LocalPath
                $created = $props.CreationTime
                $lastaccess = $props.lastaccesstime
                $laswrite = $props.lastwritetime
            }
            else{
                $created = "-"
                $lastaccess = "-"
                $laswrite = "-"
            }
            $object = [PSCustomObject]@{
                Computer = $env:COMPUTERNAME
                Name = $name
                LastUseTime = $date
                FolderCreated = $created
                FolderLastAccess = $lastaccess
                FolderLastWrite =  $laswrite
                SID = $d.SID
                Loaded = $d.Loaded
                Special = $d.Special
                LocalPath = $d.LocalPath
                RoamingConfigured = $d.RoamingConfigured
                HealthStatus = $d.HealthStatus
                LastUseTimeRaw = $d.lastusetime
                WMIPath = $d.'__PATH'
            }
            $return += $object
        }
        
        if ($UserName){
            if ($username -match '\*'){
                $return = $return | Where-Object {$_.name -like $UserName }
            }
            else {
                $return = $return | Where-Object {$UserName -contains $_.name }
            }
        }

        return $return
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
