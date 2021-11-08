function Get-ADComputerImproved {
    param (
        [Parameter( ValueFromPipeline=$true,
            Position=0)]
        [string]
        $Identity,
        [string]
        $SearchString,
        [string]
        $Filter,
        [string]
        $SearchBase,
        $Properties,
        [string]
        $Server,
        [System.Management.Automation.PSCredential]
        $Credential
    )
    Begin{
        ## Import prereq module
        Import-Module ActiveDirectory
    }
    process {
        

        ## Set Default -Properties
            $defaultproperties = "CanonicalName","WhenCreated","LastLogonDate","Description","Enabled","IPv4Address","OperatingSystem","PasswordLastSet","DNSHostName"
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

        if ($SearchString){
            $userparams.Filter = {anr -like $SearchString}
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
        Get-ADComputer @userparams
    }

}#end function