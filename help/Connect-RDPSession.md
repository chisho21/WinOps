---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Connect-RDPSession

## SYNOPSIS
Lazily launches rdp session for host when Get-VM | Open-VMConsole doesn't work.

## SYNTAX

```
Connect-RDPSession [-ComputerName] <String> [-Size <String>] [<CommonParameters>]
```

## DESCRIPTION
Lazily launches rdp session for host when Get-VM | Open-VMConsole doesn't work.

## EXAMPLES

### Example 1
```
PS C:\> Connect-RDPSession server01
```

Launch an RDP session for remote host server01

## PARAMETERS

### -ComputerName
Remote Host to connect to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Size
Predefined session size - FullScreen, 1600x900, 800x600

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: FullScreen, 1600x900, 800x600

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

