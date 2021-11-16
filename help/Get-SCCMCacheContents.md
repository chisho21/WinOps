---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SCCMCacheContents.md
schema: 2.0.0
---

# Get-SCCMCacheContents

## SYNOPSIS
Obtain a list of files in C:\windows\ccmcache

## SYNTAX

```
Get-SCCMCacheContents [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Obtain a list of files in C:\windows\ccmcache.
Helpful for checking on the SCCM cache status for patching

## EXAMPLES

### Example 1
```
PS C:\> Get-SCCMCacheContents server01 -Credential $Domaincred | ogv
       (View output in Grid View)
```

Get a list of cached files in Out-GridView for easy sorting:

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

