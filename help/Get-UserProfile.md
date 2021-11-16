---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-UserProfile.md
schema: 2.0.0
---

# Get-UserProfile

## SYNOPSIS
Retrieves user profile information from remote host(s).

## SYNTAX

```
Get-UserProfile [-ComputerName] <Object> [-DaysInactive <Int32>] [-UserName <Object>] [-IncludeSpecial]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Retrieves user profile information from remote host(s).

## EXAMPLES

### Example 1
```
PS C:\> Get-UserProfile server01

```

Retrieve all non special user profiles form remote host server01.

## PARAMETERS

### -ComputerName
Computer to execute against (accepts a list)

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
Credential to logon to remote host.

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

### -DaysInactive
Calculate days inactive (ex.
30)

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -IncludeSpecial
Include special accounts (guest, builtin admin, local system)

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
User name to filter by.

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

