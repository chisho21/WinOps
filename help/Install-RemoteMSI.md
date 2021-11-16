---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Install-RemoteMSI.md
schema: 2.0.0
---

# Install-RemoteMSI

## SYNOPSIS
Install MSI from UNC path on remote host.

## SYNTAX

```
Install-RemoteMSI [-ComputerName] <Object> [-Path] <String> [-MSIParameters <String>] [-MSILogging]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Install MSI from UNC path on remote host.


## EXAMPLES

### Example 1
```
PS C:\> Install-RemoteMSI -ComputerName server02 -Path "\\fileserver01\share\GoogleChrome\Latest\GoogleChrome_86.0.4240.111_x64.msi"
```

Install specific Google Chrome MSI on remote host server02

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

### -MSILogging
Creates log on remote host C:\temp

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

### -MSIParameters
Allows you to fill in your own MSI parameters

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
UNC path to MSI install file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
### System.String
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

