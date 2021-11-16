---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Add-ADGroupMemberImproved

## SYNOPSIS
Improved version of Add-ADGroupMember.

## SYNTAX

```
Add-ADGroupMemberImproved [-GroupName] <String[]> [-Members] <String[]> [[-Server] <String>]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Improved version of Add-ADGroupMember.

## EXAMPLES

### Example 1
```
PS C:\> Add-ADGroupMemberImproved group_1 user_1
```

Add account user_1 to group  group_1.

## PARAMETERS

### -Credential
AD Credential to use.

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

### -GroupName
Name of Group to Add to (accepts a list)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Members
Members to add to group (accepts a list)

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Domain Name to connect to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: domain.com, test.domain.com

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

