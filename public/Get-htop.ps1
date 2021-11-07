function Get-htop {

    [CmdletBinding()]
    Param (
        [string[]]
        $ComputerName,
        [Parameter(Position=1)] [Alias("l")]
        [int]$TotalList=24,
        [Parameter(Position=2)] [Alias("r")]
        [int]$RefreshRate=1,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $scriptblock = {
        While ($true) {
            
            $os = Get-Ciminstance Win32_OperatingSystem
            $osname = $os.caption
            $lastboot = Get-date $os.LastBootUpTime #-Format "MM-dd-yyyy hh:mm"
            $currenttime = Get-Date $os.LocalDateTime #-Format "MM-dd-yyyy hh:mm"
            
            $cpucores = (Get-CIMInstance Win32_PerfFormattedData_PerfOS_Processor) | Select-Object @{N="Name";E={"CPU"+ $_.name}},PercentProcessorTime | Sort-Object Name
            
            $Memusedperc = 100 - [math]::Round(($os.FreePhysicalMemory/$os.TotalVisibleMemorySize)*100,2)
            $memused =  [math]::Round(($os.TotalVisibleMemorySize - $os.FreePhysicalMemory)*1024/1GB,2)
            $memtotal = [math]::Round(($os.TotalVisibleMemorySize)*1024/1GB,2)

            $Page = Get-CimInstance -Class Win32_PageFileUsage
            $pagedata = @()
            foreach ($p in $page){
                $pageperc = [math]::Round(($p.CurrentUsage/$p.AllocatedBaseSize)*100,2)
                $pageused = [math]::Round($p.CurrentUsage/1024,2)
                $pagetotal = [math]::Round($p.AllocatedBaseSize/1024,2)
                $pobject = [pscustomobject]@{
                    Name = ($p.name -split ":")[0]
                    Used = $pageused
                    Total = $pagetotal
                    PercUsed = $pageperc
                
                }
                $pagedata += $pobject
            }
            
            $CounterSamples = Get-Counter '\Process(*)\ID Process','\Process(*)\% Processor Time','\Process(*)\Working Set' -ErrorAction SilentlyContinue | Select-Object -Expand CounterSamples
            
            $bardisplay = @()
            #CPU Display
            foreach ($core in $cpucores){
            $bar = $null
            $fgcolor = $null
            $name = $null
            $name = if ($core.name -like "*Total"){"TOTL"}else{$core.name}
                switch ($core.PercentProcessorTime){
                    {$_ -ge 0  -and $_ -lt 10}{$bar = "$name [                                         ] $($core.PercentProcessorTime)%"; $fgcolor = "Green"}
                    {$_ -ge 10 -and $_ -lt 20}{$bar = "$name [ | |                                     ] $($core.PercentProcessorTime)%"; $fgcolor = "Green"}
                    {$_ -ge 20 -and $_ -lt 30}{$bar = "$name [ | | | |                                 ] $($core.PercentProcessorTime)%"; $fgcolor = "Green"}
                    {$_ -ge 30 -and $_ -lt 40}{$bar = "$name [ | | | | | |                             ] $($core.PercentProcessorTime)%"; $fgcolor = "Green"}
                    {$_ -ge 40 -and $_ -lt 50}{$bar = "$name [ | | | | | | | |                         ] $($core.PercentProcessorTime)%"; $fgcolor = "Green"}
                    {$_ -ge 50 -and $_ -lt 60}{$bar = "$name [ | | | | | | | | | |                     ] $($core.PercentProcessorTime)%"; $fgcolor = "Green"}
                    {$_ -ge 60 -and $_ -lt 70}{$bar = "$name [ | | | | | | | | | | | |                 ] $($core.PercentProcessorTime)%"; $fgcolor = "Yellow"}
                    {$_ -ge 70 -and $_ -lt 80}{$bar = "$name [ | | | | | | | | | | | | | |             ] $($core.PercentProcessorTime)%"; $fgcolor = "Yellow"}
                    {$_ -ge 80 -and $_ -lt 90}{$bar = "$name [ | | | | | | | | | | | | | | | |         ] $($core.PercentProcessorTime)%"; $fgcolor = "Yellow"}
                    {$_ -ge 90 -and $_ -lt 95}{$bar = "$name [ | | | | | | | | | | | | | | | | | |     ] $($core.PercentProcessorTime)%"; $fgcolor = "Red"}
                {$_ -ge 95 -and $_ -le 100}{$bar = "$name [ | | | | | | | | | | | | | | | | | | | | ] $($core.PercentProcessorTime)%"; $fgcolor = "Red"}
                }
                $object = [pscustomobject]@{
                    Bar = $bar
                    Color = $fgcolor
                }
                $bardisplay += $object
                #Write-Host "$bar" -ForegroundColor $fgcolor
            }
            #RAM Display
            $ramname = "MEM "
            $fgcolor = $null
            switch ($Memusedperc){
                {$_ -ge 0  -and $_ -lt 10}{$rambar = "$ramname [                                         ] $memused / $memtotal GB"; $fgcolor = "Green"}
                {$_ -ge 10 -and $_ -lt 20}{$rambar = "$ramname [ | |                                     ] $memused / $memtotal GB";; $fgcolor = "Green"}
                {$_ -ge 20 -and $_ -lt 30}{$rambar = "$ramname [ | | | |                                 ] $memused / $memtotal GB";; $fgcolor = "Green"}
                {$_ -ge 30 -and $_ -lt 40}{$rambar = "$ramname [ | | | | | |                             ] $memused / $memtotal GB";; $fgcolor = "Green"}
                {$_ -ge 40 -and $_ -lt 50}{$rambar = "$ramname [ | | | | | | | |                         ] $memused / $memtotal GB";; $fgcolor = "Green"}
                {$_ -ge 50 -and $_ -lt 60}{$rambar = "$ramname [ | | | | | | | | | |                     ] $memused / $memtotal GB";; $fgcolor = "Green"}
                {$_ -ge 60 -and $_ -lt 70}{$rambar = "$ramname [ | | | | | | | | | | | |                 ] $memused / $memtotal GB";; $fgcolor = "Yellow"}
                {$_ -ge 70 -and $_ -lt 80}{$rambar = "$ramname [ | | | | | | | | | | | | | |             ] $memused / $memtotal GB";; $fgcolor = "Yellow"}
                {$_ -ge 80 -and $_ -lt 90}{$rambar = "$ramname [ | | | | | | | | | | | | | | | |         ] $memused / $memtotal GB";; $fgcolor = "Yellow"}
                {$_ -ge 90 -and $_ -lt 95}{$rambar = "$ramname [ | | | | | | | | | | | | | | | | | |     ] $memused / $memtotal GB";; $fgcolor = "Red"}
                {$_ -ge 95 -and $_ -le 100}{$rambar = "$ramname [ | | | | | | | | | | | | | | | | | | | | ] $memused / $memtotal GB";; $fgcolor = "Red"}
            }
            $object = [pscustomobject]@{
                Bar = $rambar
                Color = $fgcolor
            }
            $bardisplay += $object
            #Write-Host "$rambar" -ForegroundColor $fgcolor
        
            #PGFile Display
            foreach ($page in $pagedata){
                $pagename = "PG_" + $page.Name
                $pageused = $page.used
                $pagetotal = $page.total
                $fgcolor = $null
                switch ($pageperc){
                    {$_ -ge 0  -and $_ -lt 10}{$pagebar = "$pagename [                                         ] $pageused / $pagetotal GB"; $fgcolor = "Green"}
                    {$_ -ge 10 -and $_ -lt 20}{$pagebar = "$pagename [ | |                                     ] $pageused / $pagetotal GB";; $fgcolor = "Green"}
                    {$_ -ge 20 -and $_ -lt 30}{$pagebar = "$pagename [ | | | |                                 ] $pageused / $pagetotal GB";; $fgcolor = "Green"}
                    {$_ -ge 30 -and $_ -lt 40}{$pagebar = "$pagename [ | | | | | |                             ] $pageused / $pagetotal GB";; $fgcolor = "Green"}
                    {$_ -ge 40 -and $_ -lt 50}{$pagebar = "$pagename [ | | | | | | | |                         ] $pageused / $pagetotal GB";; $fgcolor = "Green"}
                    {$_ -ge 50 -and $_ -lt 60}{$pagebar = "$pagename [ | | | | | | | | | |                     ] $pageused / $pagetotal GB";; $fgcolor = "Green"}
                    {$_ -ge 60 -and $_ -lt 70}{$pagebar = "$pagename [ | | | | | | | | | | | |                 ] $pageused / $pagetotal GB";; $fgcolor = "Yellow"}
                    {$_ -ge 70 -and $_ -lt 80}{$pagebar = "$pagename [ | | | | | | | | | | | | | |             ] $pageused / $pagetotal GB";; $fgcolor = "Yellow"}
                    {$_ -ge 80 -and $_ -lt 90}{$pagebar = "$pagename [ | | | | | | | | | | | | | | | |         ] $pageused / $pagetotal GB";; $fgcolor = "Yellow"}
                    {$_ -ge 90 -and $_ -lt 95}{$pagebar = "$pagename [ | | | | | | | | | | | | | | | | | |     ] $pageused / $pagetotal GB";; $fgcolor = "Red"}
                {$_ -ge 95 -and $_ -le 100}{$pagebar = "$pagename [ | | | | | | | | | | | | | | | | | | | | ] $pageused / $pagetotal GB";; $fgcolor = "Red"}
                }
                $object = [pscustomobject]@{
                    Bar = $pagebar
                    Color = $fgcolor
                }
                $bardisplay += $object
            }#end foreach $page

            $procoutput = $CounterSamples | Group-Object { Split-Path $_.Path } | Where-Object {$_.Group[1].InstanceName -notmatch "^Idle|_Total|System$"} | 
            Sort-Object -Property {$_.Group[1].CookedValue} -Descending | Select-Object -First $using:TotalList | Format-Table @{Name="ProcessId";Expression={$_.Group[0].CookedValue}},@{Name="ProcessorUsage";Expression={[System.Math]::Round($_.Group[1].CookedValue/100/$env:NUMBER_OF_PROCESSORS,4)}},@{Name="ProcessName";Expression={$_.Group[1].InstanceName}},@{Name="WorkingSet";Expression={[System.Math]::Round($_.Group[2].CookedValue/1MB,4)}}

            Clear-Host

            Write-Host "ComputerName: $env:COMPUTERNAME"
            Write-Host "OS: $osname"
            Write-Host "Lastboot: $lastboot"
            Write-Host "CurrentTime: $currenttime"
            Write-Host "============================================================"

            foreach ($bar in $bardisplay){

                    Write-Host $bar.bar -ForegroundColor $bar.color
            
            }#end foreach $bar
            $procoutput
            Start-Sleep  -Seconds 3
        }
    }#end scriptblock

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
