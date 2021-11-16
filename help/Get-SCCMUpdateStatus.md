---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SCCMUpdateStatus.md
schema: 2.0.0
---

# Get-SCCMUpdateStatus

## SYNOPSIS
Retrieves Software Center listed updates from remote server.

## SYNTAX

```
Get-SCCMUpdateStatus [-ComputerName] <Object> [-Watch] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Machines listed as '-' have no pending updates in software center.

## EXAMPLES

### Example 1
```
PS C:\> Get-SCCMUpdateStatus -ComputerName $list -Credential $Domaincred | ogv

```

Check for Status against list of servers

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

### -Watch
Keep Rerunning script after closing Out-GridView results.

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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

