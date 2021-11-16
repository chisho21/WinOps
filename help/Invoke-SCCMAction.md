---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Invoke-SCCMAction.md
schema: 2.0.0
---

# Invoke-SCCMAction

## SYNOPSIS
Initiate SCCM actions on remote comptuer(s).

## SYNTAX

```
Invoke-SCCMAction [-ComputerName] <Object> [-Action] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Script initiates Defined SCCM Actions using the SCCM client SDK.
Helpful before and after patch cycles.

## EXAMPLES

### Example 1
```
PS C:\> Invoke-SCCMAction -ComputerName $list -Credential $Domaincred -Action MachinePolicyEval

```

Initiate Machine Policy Evaluation for list of Servers

## PARAMETERS

### -Action
Predefined SCCM Client Actions.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: MachinePolicyEval, SoftwareUpdateScan, SoftwareUpdateDeploymentEval, ApplicationDeploymentEval

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

