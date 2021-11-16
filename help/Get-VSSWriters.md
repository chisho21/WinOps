---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-VSSWriters.md
schema: 2.0.0
---

# Get-VSSWriters

## SYNOPSIS
Checks VSS Writers on a remote computer.

## SYNTAX

```
Get-VSSWriters [-ComputerName] <Object> [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Helpful when troubleshooting Avamar or other backup Issues.
Just a powershell wrapper for 'vssadmin list writers'.

## EXAMPLES

### Example 1
```
PS C:\> Get-VSSWriters -ComputerName Server01 -Credential $Domaincred | FT * -AutoSize

ComputerName Name                            State      LastError Id                                     InstanceId                             PSComputerName RunspaceId                           PSShowComputerName
------------ ----                            -----      --------- --                                     ----------                             -------------- ----------                           ------------------
Server01 Task Scheduler Writer           [1] Stable No error  {d61d61c8-d73a-4eee-8cdd-f6f9786b7124} {1bddd48e-5052-49db-9b07-b96f96727e6b} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 VSS Metadata Store Writer       [1] Stable No error  {75dfb225-e2e4-4d39-9ac9-ffaff65ddf06} {088e7a7d-09a8-4cc6-a609-ad90e75ddc93} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 Performance Counters Writer     [1] Stable No error  {0bada1de-01a9-4625-8278-69e735f39dd2} {f0086dda-9efc-47c5-8eb6-a944c3d09381} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 ASR Writer                      [1] Stable No error  {be000cbe-11fe-4426-9c58-531aa6355fc4} {cfff654f-dd00-4005-b65f-11a53f1ca6cb} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 BITS Writer                     [1] Stable No error  {4969d978-be47-48b0-b100-f328f07ac1e0} {af60a2ff-f6be-4ccc-a2e8-8fcb503d507d} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 Shadow Copy Optimization Writer [1] Stable No error  {4dc3bdd4-ab48-4d07-adb0-3bee2926fd7f} {f98da189-14ba-4bd5-a98d-16debd143c42} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 Registry Writer                 [1] Stable No error  {afbab4a2-367d-4d15-a586-71dbb18f8485} {d390d83e-139b-4d7d-9495-bf53d0ae6385} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 WMI Writer                      [1] Stable No error  {a6ad56c2-b509-4e6c-bb19-49d8f43532f0} {825c0a87-9de5-45ff-8beb-146adfb178f0} Server01   b532361f-8018-46e7-affc-134792760a49               True
Server01 COM+ REGDB Writer               [1] Stable No error  {542da469-d3e1-473c-9f4f-7847f01fc64f} {1c790ae5-2ac9-4959-9ba0-5b7ad0df42ea} Server01   b532361f-8018-46e7-affc-134792760a49               True
```

Get a status list of all VSSWriters on a remote machine.

### Example 2
```
PS C:\> Get-VSSWriters -ComputerName $list -Credential $Domaincred | Export-Excel
```

Get a status list of all VSSWriters on a list of machines and Export to Excel

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

