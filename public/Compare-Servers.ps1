function Compare-Servers {

    Param (
        [Parameter(Mandatory=$true, Position=0)]
        $Server1,
        [Parameter(Mandatory=$true, Position=1)]
        $Server2,
        [ValidateSet("SystemInfo","Services","Features","Programs","HotFixes","NetStat")]
        [Parameter(Position=2)]
        $DataSet = "SystemInfo",
        [Switch]
        $RawDataOnly,
        [System.Management.Automation.PSCredential]
        $Server1Credential = $admincred,
        [System.Management.Automation.PSCredential]
        $Server2Credential = $admincred
    )
    
    ## Define functions
    function systeminfo {
        $data1 = Get-Systeminfo -ComputerName $server1 -Credential $Server1Credential
        $data2 = Get-Systeminfo -ComputerName $server2 -Credential $Server2Credential

        if ($RawDataOnly){
            $smash = @()
            $smash += $data1
            $smash += $data2
            return $smash
        }
        else {
            Write-Verbose "Formatting data for $server1 and $server2 :: Data Type - $DataSet"
            $properties = ($data1 | Get-Member -Type NoteProperty).name
            $table = @()
            foreach ($p in $properties){
                $comp = $null
                $comp = Compare-Object -ReferenceObject $data1 -DifferenceObject $data2 -Property $p -includeEqual
                if (($comp | Measure-Object).count -eq 2){
                    $object = $null
                    $object = [PSCustomObject]@{
                        DataSet = $DataSet
                        Property = $p
                        Status = "Diff"
                        $Server1 = $comp.($p)[1]
                        $Server2 = $comp.($p)[0]
                    }
                    $table += $object
                }
                elseif (($comp | Measure-Object).count -eq 1){
                    $object = $null
                    $object = [PSCustomObject]@{
                        DataSet = $DataSet
                        Property = $p
                        Status = "Equal"
                        $Server1 = $comp.($p)
                        $Server2 = $comp.($p)
                    }
                    $table += $object
                }
                else {
                    Write-Error " WTF?!?! something happened with Compare-Object!"
                }
            }
            return $table
        }
    }#end function systeminfo

    function services {
        $data1 = Get-ServiceImproved -ComputerName $server1 -Credential $Server1Credential
        $data2 = Get-ServiceImproved -ComputerName $server2 -Credential $Server2Credential

        if ($RawDataOnly){
            $smash = @()
            $smash += $data1
            $smash += $data2
            return $smash
        }
        else{
            Write-Verbose "Formatting data for $server1 and $server2 :: Data Type - $DataSet"

            $data1list = @()
            foreach ($d in $data1){
                $object = $null
                $object = [PSCustomObject]@{
                    Computer = $server1
                    Info = $d.name + "--" + $d.LogonAs +  "--" + $d.state
                }
                $data1list += $object
            }

            $data2list = @()
            foreach ($d in $data2){
                $object = $null
                $object = [PSCustomObject]@{
                    Computer = $server2
                    Info = $d.name + "--" + $d.LogonAs +  "--" + $d.state
                }
                $data2list += $object
            }
            $compare = Compare-Object -ReferenceObject $data1list -DifferenceObject $data2list -IncludeEqual -property Info
            $finaltable = @()
            foreach ($comp in $compare){
                switch ($comp.sideindicator){
                    '==' {$status = "Equal"}
                    '<=' {$status = "$server1 ONLY"}
                    '=>' {$status = "$server2 ONLY"}
                }
                $object = $null
                $object = [PSCustomObject]@{
                    DataSet = $DataSet
                    Status = $status
                    Info = $comp.Info
                }
                $finaltable += $object
            }
            return $finaltable
        }

    }

    function features {
  
        $data1 = Invoke-Command  -ComputerName $server1 -Credential $Server1Credential { Get-WindowsFeature } 
        $data2 = Invoke-Command  -ComputerName $server2 -Credential $Server2Credential { Get-WindowsFeature }
        
        if ($RawDataOnly){
            $smash = @()
            $smash += $data1
            $smash += $data2
            return $smash
        }
        else{
            Write-Verbose "Formatting data for $server1 and $server2 :: Data Type - $DataSet"
            
            $data1list = @()
            foreach ($d in $data1){
                $object = $null
                $object = [PSCustomObject]@{
                    Info = $d.name + "--" + $d.InstallState
                }
                $data1list += $object
            }

            $data2list = @()
            foreach ($d in $data2){
                $object = $null
                $object = [PSCustomObject]@{
                    Info = $d.name + "--" + $d.InstallState
                }
                $data2list += $object
            }

            $compare = Compare-Object -ReferenceObject $data1list -DifferenceObject $data2list -IncludeEqual -property Info
            $finaltable = @()
            foreach ($comp in $compare){
                switch ($comp.sideindicator){
                    '==' {$status = "Equal"}
                    '<=' {$status = "$server1 ONLY"}
                    '=>' {$status = "$server2 ONLY"}
                }
                $object = $null
                $object = [PSCustomObject]@{
                    DataSet = $DataSet
                    Status = $status
                    Info = $comp.Info
                }
                $finaltable += $object
            }
            return $finaltable
        }
    }#end function features

    function programs {
        $data1 = Get-InstalledPrograms -ComputerName $server1 -Credential $Server1Credential
        $data2 = Get-InstalledPrograms -ComputerName $server2 -Credential $Server2Credential

        if ($RawDataOnly){
            $smash = @()
            $smash += $data1
            $smash += $data2
            return $smash
        }
        else{
            Write-Verbose "Formatting data for $server1 and $server2 :: Data Type - $DataSet"
            $data1list = @()
            foreach ($d in $data1){
                $object = $null
                $object = [PSCustomObject]@{
                    Info = $d.name + "--" + $d.version
                }
                $data1list += $object
            }

            $data2list = @()
            foreach ($d in $data2){
                $object = $null
                $object = [PSCustomObject]@{
                    Info = $d.name + "--" + $d.version
                }
                $data2list += $object
            }
            $compare = Compare-Object -ReferenceObject $data1list -DifferenceObject $data2list -IncludeEqual -property Info
            $finaltable = @()
            foreach ($comp in $compare){
                switch ($comp.sideindicator){
                    '==' {$status = "Equal"}
                    '<=' {$status = "$server1 ONLY"}
                    '=>' {$status = "$server2 ONLY"}
                }
                $object = $null
                $object = [PSCustomObject]@{
                    DataSet = $DataSet
                    Status = $status
                    Info = $comp.Info
                }
                $finaltable += $object
            }
            return $finaltable
        }
    }
    function hotfixes {
        $data1 = Invoke-Command -ComputerName $server1 -Credential $Server1Credential { Get-HotFix }
        $data2 = Invoke-Command  -ComputerName $server2 -Credential $Server2Credential { Get-HotFix }
        #$smash = $data1 += $data2
        if ($RawDataOnly){
            $smash = @()
            $smash += $data1
            $smash += $data2
            return $smash
        }
        else{
            Write-Verbose "Formatting data for $server1 and $server2 :: Data Type - $DataSet"
            $compare = Compare-Object -ReferenceObject $data1 -DifferenceObject $data2 -IncludeEqual -property HotFixID
            $finaltable = @()
            foreach ($comp in $compare){
                switch ($comp.sideindicator){
                    '==' {$status = "Equal"}
                    '<=' {$status = "$server1 ONLY"}
                    '=>' {$status = "$server2 ONLY"}
                }
                $object = $null
                $object = [PSCustomObject]@{
                    DataSet = $DataSet
                    Status = $status
                    Info = $comp.HotFixID
                }
                $finaltable += $object
            }
            return $finaltable
        }
    }#end function hotfixes

    function netstat {
        $data1 = Get-NetStat -ComputerName $server1 -Credential $Server1Credential | where-object {$_.state -eq "Listening"}
        $data2 = Get-NetStat -ComputerName $server2 -Credential $Server2Credential | where-object {$_.state -eq "Listening"}

        if ($RawDataOnly){
            $smash = @()
            $smash += $data1
            $smash += $data2
            return $smash
        }
        else{
            Write-Verbose "Formatting data for $server1 and $server2 :: Data Type - $DataSet"

            $data1list = @()
            foreach ($d in $data1){
                $object = $null
                $object = [PSCustomObject]@{
                    Computer = $server1
                    Info = $d.protocol + "--" + $d.Localaddress +  "--" + $d.processname + "--" + $d.processowner
                }
                $data1list += $object
            }

            $data2list = @()
            foreach ($d in $data2){
                $object = $null
                $object = [PSCustomObject]@{
                    Computer = $server2
                    Info = $d.protocol + "--" + $d.Localaddress +  "--" + $d.processname + "--" + $d.processowner
                }
                $data2list += $object
            }
            $compare = Compare-Object -ReferenceObject $data1list -DifferenceObject $data2list -IncludeEqual -property Info
            $finaltable = @()
            foreach ($comp in $compare){
                switch ($comp.sideindicator){
                    '==' {$status = "Equal"}
                    '<=' {$status = "$server1 ONLY"}
                    '=>' {$status = "$server2 ONLY"}
                }
                $object = $null
                $object = [PSCustomObject]@{
                    DataSet = $DataSet
                    Status = $status
                    Info = $comp.Info
                }
                $finaltable += $object
            }
            return $finaltable
        }

    }

    ## Decide and run function
    Write-Verbose "Collecting data for $server1 and $server2 :: Data Type - $DataSet"
    switch ($DataSet) {
        "systeminfo" { systeminfo }
        "services" { services }
        "features" { features }
        "programs" { programs }
        "hotfixes" { hotfixes }
        "netstat" { netstat }
    }

}
