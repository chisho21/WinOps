---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-EMCPowerPathInfo.md
schema: 2.0.0
---

# Get-EMCPowerPathInfo

## SYNOPSIS
Get EMC PowerPath Disk info

## SYNTAX

```
Get-EMCPowerPathInfo [-ComputerName] <Object> [-Detailed] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Script Retrieves Disk names, paths, etc. as provided by 'powermt display paths'.


## EXAMPLES

### Example 1
```
PS C:\> Get-EMCPowerPathInfo -ComputerName $list -Credential $Domaincred | Export-Excel
```

Export List of servers EMC info to Excel.

### Example 2
```
PS C:\> Get-EMCPowerPathInfo -ComputerName $list -Credential $Domaincred -Detailed | Export-Excel
```

Export List of servers EMC info with full details to Excel.

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
Accept pipeline input: True (ByPropertyName)
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

### -Detailed
Provide more detailed output.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

