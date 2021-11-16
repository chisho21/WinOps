---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Expand-Partition.md
schema: 2.0.0
---

# Expand-Partition

## SYNOPSIS
Expand one or all partitions to max size.

## SYNTAX

```
Expand-Partition [-ComputerName] <Object> [-DriveLetter <Object>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Expand one or all partitions to max size.

## EXAMPLES

### Example 1
```
PS C:\> Expand-Partition -ComputerName server01 -DriveLetter E
```

Expand E: Partition on server01 to it's max size.

### Example 2
```
PS C:\> Expand-Partition -ComputerName server02
```

Expand all Partitions on server02

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

### -DriveLetter
Letter of partition to expand.

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

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

