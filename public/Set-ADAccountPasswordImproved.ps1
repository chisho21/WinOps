function Set-ADAccountPasswordImproved {

    param (
        [Parameter( Mandatory=$true,ValueFromPipeline=$true,
            Position=0)]
        [string]
        $Identity,
        [System.Management.Automation.PSCredential]
        $Credential,
        [switch]
        $Reset,
        [switch]
        $WhatIf,
        [securestring]
        $OldPassword,
        [securestring]
        $NewPassword,
        [string]
        $Server
    )
    begin {
        ## Import prereq module
        Import-Module ActiveDirectory
    }
    process {
        $ParameterList = (Get-Command -Name $MyInvocation.InvocationName).Parameters.Values.Name 
        $params = @{}
        foreach ($Parameter in $ParameterList){
            $var = $null
            try {
                $var = Get-Variable -Name $parameter -ErrorAction Stop
                if ($var.Value){
                    $params.Add($parameter, $var.value)
                }

            }
            catch{}
    }

        ## Execute
        Set-ADAccountPassword @params
    }

}
