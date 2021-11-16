---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SCCMApplicationStatus.md
schema: 2.0.0
---

# Get-SCCMApplicationStatus

## SYNOPSIS
Show Software Center list of all Applications deployed to machine.

## SYNTAX

```
Get-SCCMApplicationStatus [-ComputerName] <Object> [-SearchString <String>] [-Watch]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Show Software Center list of all Applications deployed to machine.

## EXAMPLES

### Example 1
```
PS C:\> Get-SCCMApplicationStatus -ComputerName $list -Credential $Domaincred | ogv

```

Show Application info for a list of machines

### Example 2
```
PS C:\> Get-SCCMApplicationStatus -ComputerName $list -Credential $Domaincred -Watch
```

Use the -Watch parameter to keep reloading an Out-Gridview of the data.
Useful for monitoring install progress.

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

### -Watch
Keep Rerunning script after closing Out-GridView results.

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

### -SearchString
Search String for Application - accepts * as wildcard.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

