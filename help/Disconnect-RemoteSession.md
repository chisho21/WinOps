---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Disconnect-RemoteSession.md
schema: 2.0.0
---

# Disconnect-RemoteSession

## SYNOPSIS
Get information on RDP sessions for remote machine and close selected.

## SYNTAX

```
Disconnect-RemoteSession [-ComputerName] <Object> [-UserName <Object>] [-Force] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Powershell wrapper for quser and logoff.
Gathers remotesession info and allows user to select sessions to close based on Out-GridView selections.

## EXAMPLES

### Example 1
```
PS C:\> Disconnect-RemoteSession -ComputerName server01 -Credential $Domaincred -UserName user01
```

Logoff user user01 from server01.

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

### -Force
Skip Confirmations

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

### -UserName
Samaccountname of user to logoff.

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

