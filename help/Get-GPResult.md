---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-GPResult

## SYNOPSIS
Perform and retrieve a GPRESULT Report from a remote machine.
Accepts a list to run in parallel.

## SYNTAX

```
Get-GPResult [[-ComputerName] <String[]>] [-ReportType <String>] [-OutPath <Object>]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Perform and retrieve a GPRESULT Report from a remote machine.
Accepts a list to run in parallel.

## EXAMPLES

### Example 1
```
PS C:\> Get-GPResult server02
```

Get a GPRESULT for one specific machine, save in temp folder, and launch to screen.

### Example 2
```
PS C:\> Get-GPResult server02,server01 -OutPath C:\temp
```

Get a GPRESULT for two machines and place results in local C:\temp folder.

## PARAMETERS

### -ComputerName
Remote host to connect to.
Accepts list.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Credential
Admin credential to connect to remote host.

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

### -OutPath
Local path to place all reports in.

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

### -ReportType
Format of report.
Html (default) or XML.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: Html, Xml

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

