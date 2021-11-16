---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-RemoteSession.md
schema: 2.0.0
---

# Get-RemoteSession

## SYNOPSIS
Get information on RDP sessions for remote machine

## SYNTAX

```
Get-RemoteSession [-ComputerName] <Object> [-UserName <Object>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Powershell wrapper for quser that allows multiple computers to be queried.

## EXAMPLES

### Example 1
```
PS C:\> Get-RemoteSession -ComputerName server01

server01 - CONNECTED!


USERNAME       : user01
SESSIONNAME    :
ID             : 5
STATE          : Disc
IDLE TIME      : 4:44
LOGON TIME     : 10/10/2021 9:38 AM
PSComputerName : server01
RunspaceId     : 25fcd2de-cc10-4c79-ad12-bb7045cfd77a
((...TRUNCATED OUTPUT...))
```

Retrieve all logged on users from server01

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

### -UserName
Samaccountname of user to search for.

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

