---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-ADGroupMemberImproved

## SYNOPSIS
Wrapper for Get-ADGroupMember that returns group name and minimal info.
Useful for creating reports for multiple groups.

## SYNTAX

```
Get-ADGroupMemberImproved [[-Identity] <String>] [-Recursive] [-Credential <PSCredential>] [-Server <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Wrapper for Get-ADGroupMember that returns group name and minimal info.
Useful for creating reports for multiple groups.

## EXAMPLES

### Example 1
```
PS C:\> Get-ADGroupMemberImproved group01

```

## PARAMETERS

### -Credential
AD Credential to search with.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
AD Group Name

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Recursive
Specifies that the cmdlet get all members in the hierarchy of a group that do not contain child objects.
If the specified group does not have any members, then nothing is returned.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
AD Domain to search

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: domain.com, test.domain.com

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

