function Get-ADPasswordPolicyReport {

    param (
        [string]
        $Domain,
        [System.Management.Automation.PSCredential]
        $Credential
    )
    begin {
        ## Import prereq module
        Import-Module ActiveDirectory
        $params = @{}
        if ($Domain){
            $params['Domain'] = $Domain
        }
        if ($Credential){
            $params['Credential'] = $Credential
        }
    }
    process {
        
        $DefaultPolicy = Get-ADDefaultDomainPasswordPolicy @params
        $FineGrains = Get-ADFineGrainedPasswordPolicy -Filter * @params | sort-object Precedence
        $finaltable = @()
        ## add default to table
        $finaltable += [PSCustomObject]@{
            Name = "Default Domain Password Policy"
            Domain = $Domain
            Type = "Default Domain Password Policy"
            ComplexityEnabled = $defaultpolicy.ComplexityEnabled
            LockoutDuration = $defaultpolicy.LockoutDuration
            LockoutObservationWindow = $defaultpolicy.LockoutObservationWindow
            LockoutThreshold = $defaultpolicy.LockoutThreshold
            MaxPasswordAge = $defaultpolicy.MaxPasswordAge
            MinPasswordAge = $defaultpolicy.MinPasswordAge
            MinPasswordLength = $defaultpolicy.MinPasswordLength
            PasswordHistoryCount = $defaultpolicy.PasswordHistoryCount
            Precedence = "default"
            ReversibleEncryptionEnabled = $defaultpolicy.ReversibleEncryptionEnabled
            DistinguishedName = $defaultpolicy.DistinguishedName
            AppliesTo = "default"
        }

        ## add all fine grains to table
        foreach ($fg in $FineGrains){
            $finaltable += [PSCustomObject]@{
                Name = $fg.name
                Domain = $Domain
                Type = "Fine Grain Password Policy"
                ComplexityEnabled = $fg.ComplexityEnabled
                LockoutDuration = $fg.LockoutDuration
                LockoutObservationWindow = $fg.LockoutObservationWindow
                LockoutThreshold = $fg.LockoutThreshold
                MaxPasswordAge = $fg.MaxPasswordAge
                MinPasswordAge = $fg.MinPasswordAge
                MinPasswordLength = $fg.MinPasswordLength
                PasswordHistoryCount = $fg.PasswordHistoryCount
                Precedence = $fg.Precedence
                ReversibleEncryptionEnabled = $fg.ReversibleEncryptionEnabled
                DistinguishedName = $fg.DistinguishedName
                AppliesTo = $fg.appliesto -join ";"
            }
        }
        
        $finaltable

    }

}
