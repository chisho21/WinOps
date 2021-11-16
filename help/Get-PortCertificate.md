---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-PendingReboot.md
schema: 2.0.0
---

# Get-PortCertificate

## SYNOPSIS
Returns certificate information from a listening TLS/SSL service port.

## SYNTAX

```
Get-PortCertificate [[-ComputerName] <String>] [[-Port] <Int32>] [-Path <String>] [<CommonParameters>]
```

## DESCRIPTION
Gets the associated certificate from a TLS/SSL application service port.

## EXAMPLES

### EXAMPLE 1
```
Get-PortCertificate -Computername Server1 -Port 3389 -Path C:\temp -verbose
```

### EXAMPLE 2
```
"server1","server2","server3" | Get-PortCertificate
```

## PARAMETERS

### -ComputerName
Hostname or IP address of the target system (Default: localhost). 
The function uses the supplied computername to validate with the certificate's subject name(s).

```yaml
Type: String
Parameter Sets: (All)
Aliases: IPAddress, Server, Computer

Required: False
Position: 1
Default value: $env:COMPUTERNAME
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Port
Port to retrieve SSL certificate (Default: 443).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: 443
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
Directory path to save SSL certificate(s).

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Name: Get-PortCertificate
Author: Caleb Keene
Updated: 08-30-2016
Version: 1.2

## RELATED LINKS

