---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-AzureADMSConditionalAccessPolicyReport

## SYNOPSIS
Creates CSV report for auditing AzureAD Conditional Access Policies.

## SYNTAX

```
Get-AzureADMSConditionalAccessPolicyReport [[-OutputPath] <String>] [<CommonParameters>]
```

## DESCRIPTION
Creates CSV report for auditing AzureAD Conditional Access Policies.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-AzureADMSConditionalAccessPolicyReport
```

Create report and launch from temp folder.

## PARAMETERS

### -OutputPath
Specify output file name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
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

