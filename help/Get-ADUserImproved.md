---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-ADUserImproved.md
schema: 2.0.0
---

# Get-ADUserImproved

## SYNOPSIS
Gets ADUser Info but only returns commonly needed attributes.

## SYNTAX

```
Get-ADUserImproved [[-Identity] <String>] [-Credential <PSCredential>] [-Filter <String>]
 [-SearchBase <String>] [-Properties <Object>] [-Server <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets ADUser Info but only returns commonly needed attributes

## EXAMPLES

### Example 1
```
PS C:\> Get-ADUserImproved user01                           

```

Get common info for user user01

## PARAMETERS

### -Credential
Username and password to execute script.

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

### -Filter
AD Filter for search.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Identity
User SAMAccountName

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Properties
Specify Extra properties to display.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SearchBase
Define OU Limit on Search

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server
Predefined domain name

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

