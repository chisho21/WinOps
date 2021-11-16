---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Clear-SCOMHealthCache.md
schema: 2.0.0
---

# Clear-SCOMHealthCache

## SYNOPSIS
Clears the SCOM cache from remote machine and restarts service.

## SYNTAX

```
Clear-SCOMHealthCache [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Clears the SCOM cache from remote machine and restarts service.

## EXAMPLES

### Example 1
```
PS C:\>  Clear-SCOMHealthCache -ComputerName server02
```

Clear Scom health cache form remote machine server02

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

