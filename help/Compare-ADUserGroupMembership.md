---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Compare-ADUserGroupMembership.md
schema: 2.0.0
---

# Compare-ADUserGroupMembership

## SYNOPSIS
Compares two AD User group Memberships.

## SYNTAX

```
Compare-ADUserGroupMembership [-ReferenceUser] <String> [-DifferenceUser] <String> [-Server <String>]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Compares two AD User group Memberships.

## EXAMPLES

### Example 1
```
PS C:\> Compare-ADUserGroupMembership user01 user02

```

Compare group memberships of user01 and user02

## PARAMETERS

### -Credential
Username and password to execute script against AD.

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

### -DifferenceUser
User to compare to the first

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReferenceUser
User to compare to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Domain to run against.

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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

