---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-RemoteEventLog.md
schema: 2.0.0
---

# Get-RemoteEventLog

## SYNOPSIS
Retrieve Event Log From remote machine.

## SYNTAX

```
Get-RemoteEventLog [-ComputerName] <Object> [-LogName <Object>] [-Newest <Object>] [-Source <Object>]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve Event Log From remote machine.
Created becuase 'Get-EventLog' doesn't accept a Credential Param and remote sessions don't allow Out-GridView.

## EXAMPLES

### Example 1
```
PS C:\> Get-RemoteEventLog -ComuterName server01 -LogName Application -Newest 1000 | Out-GridView
```

Get the newest 1000 Application events from test machine and pipe to Out-GridView for easy searching.

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

### -LogName
Predefined Windows Log

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: System, Application, Security, Symantec Endpoint Protection Client

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Newest
Newest number of log entries

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

### -Source
Specify Log Source

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

