function Compare-ADUserGroupMembership {
    param (
        [Parameter(Mandatory=$true,Position=0)]
        [string]
        $ReferenceUser,
        [Parameter(Mandatory=$true,Position=1)]
        [string]
        $DifferenceUser,
        [Parameter(Position=2)]
        [string]
        $SearchString = "*",
        [string]
        $Server,
        [System.Management.Automation.PSCredential]
        $Credential
    )

    ## Import prereq module
    Import-Module ActiveDirectory

    ## Gather both users Group Memberships
    $groups1 = (Get-ADPrincipalGroupMembership -Identity $ReferenceUser -Server $Server -Credential $Credential).Name | Sort-Object | Where-Object {$_ -like $SearchString}
    $groups2 = (Get-ADPrincipalGroupMembership -Identity $DifferenceUser -Server $Server -Credential $Credential).Name | Sort-Object | Where-Object {$_ -like $SearchString}

    ##Compare groupmemberships
    $comparison = Compare-Object $groups1 $groups2 -IncludeEqual

    ##output
    $finaltable = @()
    foreach ($comp in $comparison){
        switch ($comp.SideIndicator){
            '==' {$description = "Both"}
            '<=' {$description = "$ReferenceUser ONLY"}
            '=>' {$description = "$DifferenceUser ONLY"}
        }
        
        $object = $null

        $object = [PSCustomObject]@{
            GroupName = $comp.inputobject
            Membership = $description
            SideIndicator = $comp.sideindicator
        }
        $finaltable += $object

    }#end foreach

    return $finaltable

}#end function