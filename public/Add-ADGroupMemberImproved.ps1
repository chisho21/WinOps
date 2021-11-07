function Add-ADGroupMemberImproved {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string[]]
        $GroupName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string[]]
        $Members,
        [Parameter(Position = 2)]
        [string]
        $Server,
        [pscredential]
        $Credential
    )

    foreach ($Group in $GroupName){
        foreach ($Member in $Members){
            $params = @{
                Identity = $Group
                Members = $Member
            }
            if ($Server){
                $params['Server'] = $Server
            }
            if ($Credential){
                $params['Credential'] = $Credential
            }
            Write-Host "Adding $member to $group"
            Add-ADGroupMember @params
        }
        
    }


}
