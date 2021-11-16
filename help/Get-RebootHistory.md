---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-RebootHistory.md
schema: 2.0.0
---

# Get-RebootHistory

## SYNOPSIS
Retrieves a myriad of reboot info from remote hosts.

## SYNTAX

```
Get-RebootHistory [-ComputerName] <Object> [-ListAllEvents] [-LastDays <Int32>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieves a myriad of reboot info from remote hosts.

## EXAMPLES

### Example 1
```
PS C:\> Get-RebootHistory server01


ComputerName           : server01
LastDays               : 90
RebootEventsCount      : 1
StartupCount           : 1
DirtyRebootCount       : 0
PercentDirty           : 0
LastShutdownDate       : 11/18/2020 7:31:23 AM
LastShutdownType       : restart
LastShutdownInfo       : The process msiexec.exe has initiated the restart of computer server01 on behalf of user NT AUTHORITY\SYSTEM for the following reason: No title for this reason could be found
LastShutdownReasonCode : 0x80030002
LastShutdownComment    : The Windows Installer initiated a system restart to complete or continue the configuration of 'Java 8 Update 261 (64-bit)'.
PSComputerName         : server01
RunspaceId             : 81fb8e08-bf2a-42e7-8870-426760e93fb9
```

Get summary reboot information for remote host server01 for the past 90 days(default)

### Example 2
```
PS C:\> Get-RebootHistory server01 -ListAllEvents | ogv
```

Report all reboot events (1074,6008, and 6009) for remote host server01 and display in out-gridview

### Example 3
```
PS C:\> Get-RebootHistory $list -LastDays 365


ComputerName           : server02
LastDays               : 365
RebootEventsCount      : 17
StartupCount           : 16
DirtyRebootCount       : 0
PercentDirty           : 0
LastShutdownDate       : 12/19/2020 7:11:54 PM
LastShutdownType       : restart
LastShutdownInfo       : The process C:\Windows\CCM\CcmExec.exe (server02) has initiated the restart of computer server02 on behalf of user NT AUTHORITY\SYSTEM for the following reason: No title for
                         this reason could be found
LastShutdownReasonCode : 0x80020001
LastShutdownComment    : Your computer will restart at 12/19/2020 07:16:54 PM to complete the installation of applications and software updates.
PSComputerName         : server02
RunspaceId             : 49d99337-deb3-402f-87ca-b05f679d07a0

ComputerName           : server01
LastDays               : 365
RebootEventsCount      : 21
StartupCount           : 16
DirtyRebootCount       : 0
PercentDirty           : 0
LastShutdownDate       : 11/18/2020 7:31:23 AM
LastShutdownType       : restart
LastShutdownInfo       : The process msiexec.exe has initiated the restart of computer server01 on behalf of user NT AUTHORITY\SYSTEM for the following reason: No title for this reason could be found
LastShutdownReasonCode : 0x80030002
LastShutdownComment    : The Windows Installer initiated a system restart to complete or continue the configuration of 'Java 8 Update 261 (64-bit)'.
PSComputerName         : server01
RunspaceId             : 218b9517-ef03-4419-8f38-9e8ae5124862
```

Retrieve summary reboot info for $list of computers for the past 365 days.

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

### -LastDays
Default 90

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

### -ListAllEvents
Only return WinEvent log info.

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

