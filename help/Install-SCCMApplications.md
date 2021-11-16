---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Install-SCCMApplications.md
schema: 2.0.0
---

# Install-SCCMApplications

## SYNOPSIS
Uses the SCCM agent to list and install Application found in Software Center.

## SYNTAX

```
Install-SCCMApplications [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Script querys a list of servers and returns the Application status as found in Software Center.
Apps chosen in Out-GridView will be installed as if performed by Software Center.

## EXAMPLES

### Example 1
```
PS C:\> Install-SCCMApplications -ComputerName Server01
(Select Application from Out-GridView)

```

Example of how to use this Cmdlet

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

