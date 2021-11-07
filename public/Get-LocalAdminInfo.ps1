function Get-LocalAdminInfo {
    Param (
        [string[]]
        $ComputerName,
        [string]
        $UserName, #Need ` as escape character so $ is not treated as a variable if useing $companyadmin
        [string]
        $SID = "S-1-5-21-*-500",
        [System.Management.Automation.PSCredential]
        $Credential 
    )

    $scriptblock = {
        if ($using:Username){
            $info = Get-LocalUser $using:Username
        }
        else {
            $info = Get-LocalUser | Where-Object {$_.sid -like $using:SID}
        }
        
        $OS = Get-CimInstance -Class Win32_OperatingSystem 
        $timestamp = Get-Date
        $object = [pscustomobject] @{
            ComputerName           = $env:COMPUTERNAME
            Name                   = $info.Name
            Enabled                = $info.Enabled
            PasswordLastSet        = $info.PasswordLastSet
            LastLogon              = $info.LastLogon
            AccountExpires         = $info.AccountExpires
            OS                     = $OS.Caption
            PasswordChangeableDate = $info.PasswordChangeableDate
            PasswordExpires        = $info.PasswordExpires
            Description            = $info.Description
            FullName               = $info.FullName
            UserMayChangePassword  = $info.UserMayChangePassword
            PasswordRequired       = $info.PasswordRequired
            SID                    = $info.SID
            DataTimeStamp          = $timestamp
        }

        return $object
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
