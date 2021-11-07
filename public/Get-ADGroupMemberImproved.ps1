function Get-ADGroupMemberImproved {

    param (
        [Parameter( ValueFromPipeline=$true,
            Position=0)]
        [string]
        $Identity,
        [switch]
        $Recursive,
        [System.Management.Automation.PSCredential]
        $Credential,
        [string]
        $Server
    )
    begin {
        ## Import prereq module
        Import-Module ActiveDirectory
    }
    process {
        ## Create Splat Table based on inputs
        $userparams = @{
            Server = $Server
            Credential = $Credential
        }

        if ($Identity){
            $userparams.Identity = $Identity
        }

        if ($Recursive){
            $userparams.Recusive = $true
        }

        ## Execute
        Get-ADGroupMember @userparams | Select-Object @{N= "ParentGroup";E={$Identity}},Samaccountname,objectclass

    }

}
