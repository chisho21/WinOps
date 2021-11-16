---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-PartitionInfo.md
schema: 2.0.0
---

# Get-PartitionInfo

## SYNOPSIS
Retrieve all partition info similar to disk management

## SYNTAX

```
Get-PartitionInfo [-ComputerName] <Object> [-DriveLetter <String[]>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieve all partition info similar to disk management

## EXAMPLES

### Example 1
```
PS C:\>  Get-PartitionInfo server01 | FT 


disknumber partitionnumber driveletter SizeGB Type OperationalStatus MaxSizeGB FreeSpaceGB DiskId                                                                                   MbrType
---------- --------------- ----------- ------ ---- ----------------- --------- ----------- ------                                                                                   -------
         3               1           Y     45 IFS  Online                   45       37.64 \\?\scsi#disk&ven_vmware&prod_virtual_disk#000300#{53f56307-b6bf-11d0-94f2-00a0c91efb8b}       7
         2               1           D    600 IFS  Online                  600       20.55 \\?\scsi#disk&ven_vmware&prod_virtual_disk#000200#{53f56307-b6bf-11d0-94f2-00a0c91efb8b}       7
         1               1               0.12 R... Unknown                                 \\?\scsi#disk&ven_vmware&prod_virtual_disk#000100#{53f56307-b6bf-11d0-94f2-00a0c91efb8b}        
         1               2           M 149.87 B... Online               149.87       59.25 \\?\scsi#disk&ven_vmware&prod_virtual_disk#000100#{53f56307-b6bf-11d0-94f2-00a0c91efb8b}        
         0               1               0.49 IFS  Online                                  \\?\scsi#disk&ven_vmware&prod_virtual_disk#000000#{53f56307-b6bf-11d0-94f2-00a0c91efb8b}       7
```

Get all partition info for server01 and display as a Table

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

### -DriveLetter
Return only DriveLetter(s)

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

