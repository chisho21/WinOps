---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-SChannelInfo.md
schema: 2.0.0
---

# Get-SChannelInfo

## SYNOPSIS
Retrieve relavent SCHANNEL info from registry.
Replacement for IISCrypto.

## SYNTAX

```
Get-SChannelInfo [-ComputerName] <Object> [-Type <Object>] [-EnabledOnly] [-DisabledOnly]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Retrieve relavent SCHANNEL info from registry.
Replacement for IISCrypto.

## EXAMPLES

### Example 1
```
PS C:\> Get-SChannelInfo server01 | FT

ComputerName CipherName     Type           Enabled KeyPresent Path                                                                                                  
------------ ----------     ----           ------- ---------- ----                                                                                                  
server01 RC2 128/128    Cipher           False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 128\128                 
server01 RC2 56/128     Cipher            True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 56\128                  
server01 RC2 40/128     Cipher           False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC2 40\128                  
server01 RC4 128/128    Cipher           False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 128\128                 
server01 RC4 64/128     Cipher           False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 64\128                  
server01 RC4 56/128     Cipher           False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\RC4 56\128                  
server01 DES 56/56      Cipher            True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\DES 56\56                   
server01 Triple DES 168 Cipher           False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\Triple DES 168              
server01 AES 128/128    Cipher            True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 128\128                 
server01 AES 256/256    Cipher            True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Ciphers\AES 256\256                 
server01 SSL 2.0        ClientProtocol   False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Client            
server01 SSL 3.0        ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client            
server01 TLS 1.0        ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client            
server01 TLS 1.1        ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client            
server01 TLS 1.2        ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client            
server01 SSL 2.0        ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server            
server01 SSL 3.0        ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server            
server01 TLS 1.0        ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server            
server01 TLS 1.1        ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server            
server01 TLS 1.2        ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server            
server01 MD5            Hash              True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\MD5                          
server01 SHA            Hash              True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA                          
server01 SHA 256        Hash              True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA 256                      
server01 SHA 384        Hash              True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA 384                      
server01 SHA 512        Hash              True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Hashes\SHA 512                      
server01 Diffie-Hellman KeyExchange      False       True HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\Diffie-Hellman
server01 PKCS           KeyExchange       True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\PKCS          
server01 ECDH           KeyExchange       True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\KeyExchangeAlgorithms\ECDH
```

Get all schannel info for server01 and display as table.

### Example 2
```
PS C:\> Get-SChannelInfo server01 -Type Protocol -EnabledOnly | FT

ComputerName CipherName Type           Enabled KeyPresent Path                                                                                       
------------ ---------- ----           ------- ---------- ----                                                                                       
server01 SSL 3.0    ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Client 
server01 TLS 1.0    ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Client 
server01 TLS 1.1    ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Client 
server01 TLS 1.2    ClientProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Client 
server01 SSL 2.0    ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 2.0\Server 
server01 SSL 3.0    ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\SSL 3.0\Server 
server01 TLS 1.0    ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.0\Server 
server01 TLS 1.1    ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.1\Server 
server01 TLS 1.2    ServerProtocol    True      False HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\SCHANNEL\Protocols\TLS 1.2\Server
```

Get only enabled client/server protocols info for server01.

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

### -DisabledOnly
Only return disabled protocols.

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

### -EnabledOnly
Only return enabled protocols.

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

### -Type
Select predefined type of SCHANNEL

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: ALL, Cipher, Protocol, Hash, KeyExchange

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

