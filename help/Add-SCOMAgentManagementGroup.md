---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Add-SCOMAgentManagementGroup.md
schema: 2.0.0
---

# Add-SCOMAgentManagementGroup

## SYNOPSIS
Adds a SCOM management group from an Agent.

## SYNTAX

```
Add-SCOMAgentManagementGroup [-ComputerName] <Object> -ManagementGroupName <Object> -ManagementServer <Object>
 [-ManagementServerPort <Object>] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Adds a SCOM management group from an Agent.
Useful for SCOM Migrations

## EXAMPLES

### Example 1
```
PS C:\> Add-SCOMAgentManagementGroup -ComputerName server01 -ManagementGroupName ProdMG -ManagementServer scomserver00.domain.com
```

Add ProdMG management group to server scomserver00.domain.com

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
SCOM ManagementGroup Name

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagementServer
SCOM Management Server Name

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ManagementServerPort
Management Port default is 5723

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

