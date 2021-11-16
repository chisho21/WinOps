---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-InstalledPrograms.md
schema: 2.0.0
---

# Get-InstalledPrograms

## SYNOPSIS
Gathers add/remove program info for remote computer.

## SYNTAX

```
Get-InstalledPrograms [-ComputerName] <Object> [-searchstring <Object>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Script Checks the registry for installed programs.
By default it pulls all programs found, but you can also define a "searchstring".

## EXAMPLES

### Example 1
```
PS C:\> Get-InstalledPrograms -ComputerName $list -Credential $Domaincred | Export-Excel
```

Get All Installed Programs for a $list and export to excel

### Example 2
```
PS C:\> Get-InstalledPrograms -ComputerName $list -searchstring "*Google Chrome*" -Credential $Domaincred | Export-Excel
```

Get version of google chrome installed for list of computers.

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

