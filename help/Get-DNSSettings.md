---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-DNSSettings.md
schema: 2.0.0
---

# Get-DNSSettings

## SYNOPSIS
Retrieve DNS settings from remote host.

## SYNTAX

```
Get-DNSSettings [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve DNS settings from remote host.

## EXAMPLES

### Example 1
```
PS C:\> Get-DNSSettings -ComputerName server02            



Computer       : server02
InterfaceAlias : Ethernet0 2
DNS1           : 8.8.8.8
DNS2           : 8.8.4.4
DNS3           : 
PSComputerName : server02
```

Retrieve DNS settings for server02.

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

