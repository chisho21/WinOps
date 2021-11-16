---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-ADComputerImproved.md
schema: 2.0.0
---

# Get-ADComputerImproved

## SYNOPSIS
Gets ADComputer Info but only returns commonly needed attributes.

## SYNTAX

```
Get-ADComputerImproved [[-Identity] <String>] [-Filter <String>] [-SearchBase <String>] [-Properties <Object>]
 [-Server <String>] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Gets ADComputer Info but only returns commonly needed attributes.

## EXAMPLES

### Example 1
```
PS C:\> Get-ADComputerImproved server01 -Credential $Domaincred

```

Get Pertinent AD Info for server01

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
Computer SAMAccountName

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

