function Get-ADServiceAccountImproved {

    param (
        [Parameter( ValueFromPipeline=$true,
            Position=0)]
        [string]
        $Identity,
        [System.Management.Automation.PSCredential]
        $Credential,
        [string]
        $Filter,
        [string]
        $SearchBase,
        $Properties,
        [string]
        $Server
    )
    begin {
        ## Import prereq module
        Import-Module ActiveDirectory
    }
    process {
        ## Set Default -Properties
            $defaultproperties = "CanonicalName","WhenCreated","LastLogonDate","Description","companyCustom103","DNSHostName","MemberOf","Enabled","LockedOut","PasswordExpired","PasswordLastSet","PasswordNeverExpires"
        ## Create Splat Table based on inputs
        $userparams = @{
            Server = $Server
        }

        if ($Identity){
            $userparams.Identity = $Identity
        }

        if ($Credential){
            $userparams.Credential = $Credential
        }

        if ($Filter){
            $userparams.Filter = $Filter
        }

        if ($SearchBase){
            $userparams.SearchBase = $SearchBase
        }

        if ($Properties){
            $userparams.Properties = $Properties + $defaultproperties
        }
        else {
            $userparams.Properties = $defaultproperties
        }
        
        ## Execute
        Get-ADServiceAccount @userparams
    }

}
