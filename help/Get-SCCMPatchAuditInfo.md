---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SCCMPatchAuditInfo.md
schema: 2.0.0
---

# Get-SCCMPatchAuditInfo

## SYNOPSIS
Gathers pertinent KB and Program info for after a patch window.

## SYNTAX

```
Get-SCCMPatchAuditInfo [-ComputerName] <Object> [-KBs <Object>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Script Checks for KB's and listed program versions on remote machiens.
No logic is built in to the script to identify machines out of compliance.
KB's need to be defined in an array variable prior to use.

## EXAMPLES

### Example 1
```
PS C:\> Get-SCCMPatchAuditInfo -ComputerName $list -Credential $Domaincred -KBs $KBList | Export-Excel
```

Get Patch Audit Info for a $list and export to excel

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

### -KBs
List of KB's to check for installation status.

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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

