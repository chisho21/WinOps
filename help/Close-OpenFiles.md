---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Close-OpenFiles.md
schema: 2.0.0
---

# Close-OpenFiles

## SYNOPSIS
Close open SMB files on remote server.

## SYNTAX

```
Close-OpenFiles [-ComputerName] <String[]> [-SearchString <String[]>] [-Force] [-SelectAll]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Script enumerates open file shares on a remote server and allows the user to select from an Out-GridView.
The script then attempts to close these open files.
User is required to confirm every file close by default.


## EXAMPLES

### Example 1
```
PS C:\> Close-OpenFiles -ComputerName Server01
```

## PARAMETERS

### -ComputerName
Name of Computer (accepts list of Computers)

```yaml
Type: String[]
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

### -Force
No Confirmations (DANGER!!)

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

### -SearchString
Filepath to search for.
Accepts wildcards *

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -SelectAll
Non interactive select option.
(DANGER!!)

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

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

