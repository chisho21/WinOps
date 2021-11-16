---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-LocalUserRightsAssignment

## SYNOPSIS
Retrieve local User Rights Assignments from remote server(s).

## SYNTAX

```
Get-LocalUserRightsAssignment [-ComputerName] <String[]> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve local User Rights Assignments from remote server(s).

## EXAMPLES

### Example 1
```
PS C:\> Get-LocalUserRightsAssignment -ComputerName server01 | ogv
```

Get rights assignments for remote machine server01 and return to an out-gridview for easy parsing.

## PARAMETERS

### -ComputerName
Remote host(s) to run against.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Credential
Admin Credential for Remote Host(s)

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

### System.String[]
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

