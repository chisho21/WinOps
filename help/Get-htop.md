---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-htop.md
schema: 2.0.0
---

# Get-htop

## SYNOPSIS
Get resource usage of remote machine.

## SYNTAX

```
Get-htop [-ComputerName] <Object> [[-TotalList] <Int32>] [[-RefreshRate] <Int32>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Imitation of linux program htop.

## EXAMPLES

### Example 1
```
PS C:\> get-htop -ComputerName server01 -Credential $Domaincred

ComputerName: server01
OS: Microsoft Windows Server 2012 R2 Datacenter
Lastboot: 06/18/2020 18:01:49
CurrentTime: 06/25/2020 09:29:30
============================================================
TOTL [                                         ] 3%
CPU0 [                                         ] 0%
CPU1 [                                         ] 0%
CPU2 [                                         ] 0%
CPU3 [                                         ] 0%
CPU4 [                                         ] 0%
CPU5 [                                         ] 6%
CPU6 [                                         ] 6%
CPU7 [ | |                                     ] 12%
MEM  [ | | | | | | | | | | | | | |             ] 22.55 / 32 GB
PG_C [                                         ] 0.5 / 4 GB
PG_Y [                                         ] 0.02 / 22.19 GB

ProcessId ProcessorUsage ProcessName                       WorkingSet
--------- -------------- -----------                       ----------
    21196         0.0233 explorer                            151.3711
     1112         0.0213 jp2launcher                         350.7773
      624         0.0078 services                             13.0547
     4728         0.0039 xagt                                219.4766
      760         0.0039 svchost                              21.0312
      944         0.0039 svchost                             165.3867
     3552         0.0039 wmiprvse                               59.75
    15820         0.0019 explorer                            111.5039
    10928         0.0019 wsmprovhost                         111.3203
     5884         0.0019 explorer                            114.9766
    24612         0.0019 jp2launcher                         229.6719
      632         0.0019 lsass                                40.4609
    12852              0 taskhostex                            8.6758
    25968              0 right click tools desktop            93.0312
     9064              0 ccsvchst                              3.2773
     8420              0 vm3dservice                           4.5195
     9740              0 scnotification                       42.3086
    11476              0 explorer                            127.4414
    20988              0 microsoft.configurationmanagement   200.0547
    11400              0 rdpclip                                 7.25
     8884              0 jp2launcher                         318.0742
     1896              0 jp2launcher                         263.2227
    12808              0 jp2launcher                         307.9297
```

Show resource usage for remote computer server01

### Example 2
```
PS C:\> get-htop -ComputerName server01 -Credential $Domaincred -RefreshRate 20
```

Same as example 1 with a longer refresh time of 20 seconds.
Default is 1 second.

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

### -RefreshRate
Set Refresh rate in seconds.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: r

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TotalList
Number of Processes to show.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: l

Required: False
Position: 1
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

