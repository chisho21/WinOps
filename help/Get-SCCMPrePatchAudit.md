---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SCCMPrePatchAudit.md
schema: 2.0.0
---

# Get-SCCMPrePatchAudit

## SYNOPSIS
Run before patch window to identify potential problems.

## SYNTAX

```
Get-SCCMPrePatchAudit [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Identifies cache, hdd space, and other SCCM patch related issues.
No logic built in just gathers relavant data.

## EXAMPLES

### Example 1
```
PS C:\> Get-SCCMPrePatchAudit -ComputerName $serverlist -Credential $Domaincred | Export-Excel
Working through 19 Servers... Please HOLD...
All SERVER connections completed in 23.5697158 seconds.
(Read output in Excel)
```

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

