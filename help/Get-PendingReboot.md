---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-PendingReboot.md
schema: 2.0.0
---

# Get-PendingReboot

## SYNOPSIS
Get information regarding pending reboots

## SYNTAX

```
Get-PendingReboot [-ComputerName] <Object> [-Detailed] [-SkipConfigurationManagerClientCheck]
 [-SkipPendingFileRenameOperationsCheck] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Get information regarding pending reboots

## EXAMPLES

### Example 1
```
PS C:\>  Get-PendingReboot server01                                     

ComputerName    : server01
IsRebootPending : True
PSComputerName  : server01
RunspaceId      : 2a5d3382-5e0a-4d07-8bda-8226b5f6ccd5
```

Return Simple pending reboot info for server01

### Example 2
```
PS C:\>  Get-PendingReboot server01 -Detailed

ComputerName                     : server01
IsRebootPending                  : True
ComponentBasedServicing          : True
PendingComputerRenameDomainJoin  : False
PendingFileRenameOperations      : True
PendingFileRenameOperationsValue : \??\C:\Program Files (x86)\Google\Update\1.3.36.32;;\??\C:\Program Files\Mozilla Firefox\tobedeleted\rep22a3fd82-3be9-4e14-8a3b-5e0fec91a402;;\??\C:\Program Files\Mozilla
                                   Firefox\tobedeleted\rep22a3fd82-3be9-4e14-8a3b-5e0fec91a402;;\??\C:\Program Files\Mozilla Firefox\tobedeleted\;;\??\C:\Program Files (x86)\Mozilla Maintenance Service\maintenanceservice_tmp.exe;;\??\C:\Config.Msi\9012fecd.rbf;    
SystemCenterConfigManager        : True
WindowsUpdateAutoUpdate          : True
PSComputerName                   : server01
RunspaceId                       : c400d27f-bed7-4284-b3bf-b887ded5ccdd
```

Return Simple pending reboot info for server01

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

### -Detailed
Return ALL details.

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

### -SkipConfigurationManagerClientCheck
Skip SCCM check.

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

### -SkipPendingFileRenameOperationsCheck
Skip file rename check

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

