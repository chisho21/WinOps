function Get-ClusterInfo {
    Param (
        [string[]]
        $ComputerName,
        [ValidateSet("Name","Node","Group","Resource","ALL")]
        $Scope = "ALL",
        [System.Management.Automation.PSCredential]
        $Credential
    )

    $params = @{}
    if ($ComputerName){
        $params['ComputerName'] = $ComputerName
    }
    if ($Credential){
        $params['Credential'] = $Credential
    }

    $namescriptblock = {
        Get-Cluster -ErrorAction SilentlyContinue | Select-Object name,domain 
    }# end script block

    $nodescriptblock = {
        Get-ClusterNode -ErrorAction SilentlyContinue | Select-Object name,state,cluster
    }# end script block

    $groupscriptblock = {
        Get-ClusterGroup | Select-Object name,cluster,ownernode,state
    }# end script block

    $resourcescriptblock = {
        Get-ClusterResource | Select-Object name,state,resourcetype,ownergroup,ownernode,cluster
    }# end script block

    if ($Scope -eq "ALL"){
        $return = @()
        $return += "======Cluster Name=========="
        $return += Invoke-Command @params -ScriptBlock $namescriptblock |  Format-Table
        $return += "======Cluster Node(s)=========="
        $return += Invoke-Command @params -ScriptBlock $nodescriptblock |  Format-Table
        $return += "======Cluster Group=========="
        $return += Invoke-Command @params -ScriptBlock $groupscriptblock |  Format-Table
        $return += "======Cluster Resources=========="
        $return += Invoke-Command @params -ScriptBlock $resourcescriptblock |  Format-Table
        return $return
    }
    else {
        switch ($Scope){
            'Name' {$scriptblock = $namescriptblock ; break}
            'Node' {$scriptblock = $nodescriptblock ; break}
            'Group' {$scriptblock = $groupscriptblock ; break}
            'Resource' {$scriptblock = $resourcescriptblock ; break}
        }
            
            Invoke-Command @params -ScriptBlock $scriptblock
    }
    

}
