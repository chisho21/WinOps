---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-ADPasswordPolicyReport

## SYNOPSIS
Retrieve default and fine grained password policies for a domain and return as one object.

## SYNTAX

```
Get-ADPasswordPolicyReport [[-Domain] <String>] [[-Credential] <PSCredential>]
```

## DESCRIPTION
Retrieve default and fine grained password policies for a domain and return as one object.
Combines usage of Get-ADDefaultDomainPasswordPolicy and Get-ADFineGrainedPasswordPolicy

## EXAMPLES

### Example 1
```
PS C:\>  Get-ADPasswordPolicyReport -Domain domain.com -Credential $Domaincred | FT

```

## PARAMETERS

### -Credential
Domain Credential with rights to view password policies.

```yaml
Type: PSCredential
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Domain
Domain name to query against.

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

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

