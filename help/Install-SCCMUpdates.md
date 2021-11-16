---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Install-SCCMUpdates.md
schema: 2.0.0
---

# Install-SCCMUpdates

## SYNOPSIS
Install ALL Required Software/OS Updates as listed in Software Center.

## SYNTAX

```
Install-SCCMUpdates [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Utilizing the SCCM SDK, this script initiates an install of all pending updates as defined in Software Center.

## EXAMPLES

### Example 1
```
PS C:\> Install-SCCMUpdates -ComputerName $list -Credential $Domaincred
```

Start Updates on list of machines in Domain domain.


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

