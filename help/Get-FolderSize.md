---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help
schema: 2.0.0
---

# Get-FolderSize

## SYNOPSIS
Gets folder sizes using COM and by default with a fallback to robocopy.exe, with the logging only option, which makes it not actually copy or move files, but just list them, and the end summary result is parsed to extract the relevant data.

There is a -ComOnly parameter for using only COM, and a -RoboOnly parameter for using only robocopy.exe with the logging only option.

The robocopy output also gives a count of files and folders, unlike the COM method output.
The default number of threads used by robocopy is 8, but I set it to 16 since this cut the run time down to almost half in some cases during my testing.
You can specify a number of threads between 1-128 with the parameter -RoboThreadCount.

Both of these approaches are apparently much faster than .NET and Get-ChildItem in PowerShell.

The properties of the objects will be different based on which method is used, but the "TotalBytes" property is always populated if the directory size was successfully retrieved.
Otherwise you should get a warning (and the sizes will be zero).

Online documentation: http://www.powershelladmin.com/wiki/Get_Folder_Size_with_PowerShell,_Blazingly_Fast

MIT license.
http://www.opensource.org/licenses/MIT

Copyright (C) 2015-2017, Joakim Svendsen All rights reserved.
Svendsen Tech.

## SYNTAX

### Path (Default)
```
Get-FolderSize [-Path] <String[]> [-Precision <Int32>] [-RoboOnly] [-ComOnly] [-RoboThreadCount <Byte>]
 [<CommonParameters>]
```

### LiteralPath
```
Get-FolderSize [-Precision <Int32>] [-RoboOnly] [-ComOnly] [-LiteralPath] <String[]> [-RoboThreadCount <Byte>]
 [<CommonParameters>]
```

## DESCRIPTION
Gets folder sizes using COM and by default with a fallback to robocopy.exe, with the logging only option, which makes it not actually copy or move files, but just list them, and the end summary result is parsed to extract the relevant data.

There is a -ComOnly parameter for using only COM, and a -RoboOnly parameter for using only robocopy.exe with the logging only option.

The robocopy output also gives a count of files and folders, unlike the COM method output.
The default number of threads used by robocopy is 8, but I set it to 16 since this cut the run time down to almost half in some cases during my testing.
You can specify a number of threads between 1-128 with the parameter -RoboThreadCount.

Both of these approaches are apparently much faster than .NET and Get-ChildItem in PowerShell.

The properties of the objects will be different based on which method is used, but the "TotalBytes" property is always populated if the directory size was successfully retrieved.
Otherwise you should get a warning (and the sizes will be zero).

Online documentation: http://www.powershelladmin.com/wiki/Get_Folder_Size_with_PowerShell,_Blazingly_Fast

MIT license.
http://www.opensource.org/licenses/MIT

Copyright (C) 2015-2017, Joakim Svendsen All rights reserved.
Svendsen Tech.

## EXAMPLES

### EXAMPLE 1
```
. .\Get-FolderSize.ps1
```

PS C:\\\> 'C:\Windows', 'E:\temp' | Get-FolderSize

### EXAMPLE 2
```
Get-FolderSize -Path Z:\Database -Precision 2
```

### EXAMPLE 3
```
Get-FolderSize -Path Z:\Database -RoboOnly -RoboThreadCount 64
```

### EXAMPLE 4
```
Get-FolderSize -Path Z:\Database -RoboOnly
```

### EXAMPLE 5
```
Get-FolderSize A:\FullHDFloppyMovies -ComOnly
```

## PARAMETERS

### -Path
Path or paths to measure size of.

```yaml
Type: String[]
Parameter Sets: Path
Aliases: Name, FullName

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName, ByValue)
Accept wildcard characters: False
```

### -Precision
Number of digits after decimal point in rounded numbers.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 4
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoboOnly
Do not use COM, only robocopy, for always getting full details.

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

### -ComOnly
Never fall back to robocopy, only use COM.

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

### -LiteralPath
Path or paths to measure size of, supporting wildcard characters in the names, as with Get-ChildItem.

```yaml
Type: String[]
Parameter Sets: LiteralPath
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RoboThreadCount
Number of threads used when falling back to robocopy, or with -RoboOnly.
Default: 16 (gave the fastest results during my testing).

```yaml
Type: Byte
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: 16
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

