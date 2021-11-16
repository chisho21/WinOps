---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-ServiceImproved.md
schema: 2.0.0
---

# Get-ServiceImproved

## SYNOPSIS
Improved version of Get-Service that pulls info similar to services.msc from remote machines.

## SYNTAX

```
Get-ServiceImproved [-ComputerName] <Object> [-searchstring <Object>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Improved version of Get-Service that pulls info similar to services.msc from remote machines.

## EXAMPLES

### Example 1
```
PS C:\> Get-ServiceImproved -ComputerName $list -Credential $Domaincred | Out-GridView
```

Get All Services on list of computers and display in Out-GridView

## PARAMETERS

### -ComputerName
Name of Computer (accepts list of Computers)

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### -searchstring
Search string for querey using wild cards *

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

