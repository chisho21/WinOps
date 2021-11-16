---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Remove-SCCMMaintenanceWindow.md
schema: 2.0.0
---

# Remove-SCOMAgentManagementGroup

## SYNOPSIS
Removes a SCOM management group from an Agent.

## SYNTAX

```
Remove-SCOMAgentManagementGroup [-ComputerName] <Object> [-ManagementGroupName] <String>
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Removes a SCOM management group from an Agent.
Useful for SCOM Migrations

## EXAMPLES

### Example 1
```
PS C:\> Remove-SCOMAgentManagementGroup -ComputerName server01 -ManagementGroupName ProdMG
```

Remove ProdMG servers from scom agent.

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

### -ManagementGroupName
PreDefined SCOM ManagementGroup Name to Remove.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

