function Get-RebootHistory {
    Param(
        $ComputerName,
        [Switch]
        $ListAllEvents,
        [int]$LastDays = 90,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        $days = $using:lastdays
        $starttime = (Get-date).AddDays(-$days)
        $filter = @{
            LogName='System'
            ID = 1074,6008,6009
            StartTime = $starttime
        }

        $allevents = Get-WinEvent -FilterHashTable $filter| Sort-Object TimeCreated -Descending

        $events = $allevents | Where-Object {$_.id -eq 1074}
        $startups = $allevents | Where-Object {$_.id -eq 6009}
        $dirty = $allevents | Where-Object {$_.id -eq 6008}

        if (!$using:ListAllEvents){
            $lastshutdown = $events | Select-Object -first 1
            $message = $lastshutdown.message -split "\r\n"
            $reasoncode = $message | Where-Object {$_ -like "*Reason Code:*"}
            $reasoncode = if($reasoncode){(($reasoncode -split ':').trim())[1]}else{"N/A"}
            $type = $message | Where-Object {$_ -like "*Shutdown Type:*"}
            $type = if($type){(($type -split ':').trim())[1]}else{"N/A"}
            $comment = $message | Where-Object {$_ -like "*comment:*"}
            $comment = if($comment){(($comment -split 'Comment: ').trim())[1]}else{"N/A"}
            $OS = Get-CimInstance -Class Win32_OperatingSystem 
            $Uptime = New-TimeSpan $OS.LastBootUpTime $OS.LocalDateTime -ErrorAction SilentlyContinue

            [PSCustomObject]@{
                ComputerName = $env:COMPUTERNAME
                LastDays = $days
                Uptime = "{0} days {1} hours {2} minutes" -f $Uptime.Days, $Uptime.Hours, $Uptime.Minutes
                RebootEventsCount = $events.count
                StartupCount = $startups.count
                DirtyRebootCount = $dirty.count
                PercentDirty = $dirty.count / $startups.count
                LastShutdownDate = $lastshutdown.TimeCreated
                LastShutdownType = $type
                LastShutdownInfo = $message[0]
                LastShutdownReasonCode = $reasoncode
                LastShutdownComment = $comment
            }

        }
        else {
            return $allevents
        }
        
    } # end scriptblock

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
