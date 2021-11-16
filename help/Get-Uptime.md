---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-Uptime

## SYNOPSIS
Gather Uptime information for remote hosts via powershell remoting.
Useful when rebooting a list of machines.

## SYNTAX

```
Get-Uptime [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Gather Uptime information for remote hosts via powershell remoting.
Useful when rebooting a list of machines.

## EXAMPLES

### Example 1
```
PS C:\> Get-Uptime server01

ComputerName   : server01
Uptime         : 8 days 10 hours 41 minutes
LastReboot     : 5/19/2021 1:06:36 PM
PSComputerName : server01
RunspaceId     : 13feec41-adcd-4f9d-82c9-ad58507f1370
```

Get uptime for remote host server01.

## PARAMETERS

### -ComputerName
Remote host to connect to.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Credential
Admin credential for remote host.

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

