---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SystemInfo.md
schema: 2.0.0
---

# Get-SystemInfo

## SYNOPSIS
Powershell replacement for "systeminfo"

## SYNTAX

```
Get-SystemInfo [-ComputerName] <Object> [-HotFixInfo] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Powershell replacement for "systeminfo".
Pulls additional useful info for WinOps.

## EXAMPLES

### Example 1
```
PS C:\> Get-SystemInfo -ComputerName server01 -Credential $Domaincred



ComputerName        : server01
Domain              : domain.com
OSName              : Microsoft Windows Server 2012 R2 Datacenter
OSVersion           : 6.3.9600
OSArch              : 64-bit
OriginalInstallDate : 2/16/2016 10:05:33 AM
Uptime              : 42 days 12 hours 49 minutes
LastReboot          : 7/22/2020 7:29:47 AM
LastRebootEvent     : @{TimeStamp=7/22/2020 7:29:25 AM; User=NT AUTHORITY\SYSTEM; Reason/Application=msiexec.exe; Action=restart}
TimeZone            : (UTC-05:00) Eastern Time (US & Canada)
SystemModel         : VMware Virtual Platform
BIOSVersion         : PhoenixBIOS 4.0 Release 6.0      (INTEL  - 6040000)
Processor           : Intel(R) Xeon(R) CPU E5-2683 v3 @ 2.00GHz (8 Core(s), 8 Logical Processor(s))
RAM                 : 7.09 / 32.00 GB (22.1% Free)
LogicalDisks        : [NTFS] C:\ (OS) = 23.21 / 249.51 GB (9.3% Free)
                      [NTFS] D:\ (DATA) = 31.27 / 600.00 GB (5.2% Free)
                      [NTFS] Y:\ (PAGE) = 40.91 / 45.00 GB (90.9% Free)
PSVersion           : 5.1.14409.1018
PRC                 :
Cutover             :
ManagedBy           : Core

SCOM                : 7.1.10184.0
SCCM                : 5.00.8740.1024
LastHotFixInstalled : 'HotFixInfo' Flag not set.
PSComputerName      : server01
```

Retrieve useful systeminfo for server01

### Example 2
```
PS C:\>  Get-SystemInfo -ComputerName server01 -Credential $Domaincred -HotFixInfo



ComputerName        : server01
Domain              : domain.com
OSName              : Microsoft Windows Server 2012 R2 Datacenter
OSVersion           : 6.3.9600
OSArch              : 64-bit
OriginalInstallDate : 2/16/2016 10:05:33 AM
Uptime              : 42 days 12 hours 49 minutes
LastReboot          : 7/22/2020 7:29:47 AM
LastRebootEvent     : @{TimeStamp=7/22/2020 7:29:25 AM; User=NT AUTHORITY\SYSTEM; Reason/Application=msiexec.exe; Action=restart}
TimeZone            : (UTC-05:00) Eastern Time (US & Canada)
SystemModel         : VMware Virtual Platform
BIOSVersion         : PhoenixBIOS 4.0 Release 6.0      (INTEL  - 6040000)
Processor           : Intel(R) Xeon(R) CPU E5-2683 v3 @ 2.00GHz (8 Core(s), 8 Logical Processor(s))
RAM                 : 7.16 / 32.00 GB (22.4% Free)
LogicalDisks        : [NTFS] C:\ (OS) = 23.21 / 249.51 GB (9.3% Free)
                      [NTFS] D:\ (DATA) = 31.27 / 600.00 GB (5.2% Free)
                      [NTFS] Y:\ (PAGE) = 40.91 / 45.00 GB (90.9% Free)
PSVersion           : 5.1.14409.1018
PRC                 :
Cutover             :
ManagedBy           : Core

SCOM                : 7.1.10184.0
SCCM                : 5.00.8740.1024
LastHotFixInstalled : @{hotfixID=KB4569768; InstalledOn=8/19/2020 12:00:00 AM; InstalledBy=NT AUTHORITY\SYSTEM}
PSComputerName      : server01
```

Retrieve useful systeminfo for server01, but include the last hotfix installed.
Takes extra time.

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

### -HotFixInfo
Pulls info via Get-Hotfix.
Takes extra time, especially on older servers with a lot of KB's installed.

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

