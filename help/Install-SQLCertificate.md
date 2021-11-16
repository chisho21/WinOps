---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Install-SQLCertificate.md
schema: 2.0.0
---

# Install-SQLCertificate

## SYNOPSIS
Used for installing certificates on SQL servers (clusters).

## SYNTAX

```
Install-SQLCertificate [-ComputerName] <String[]> [-SQLInstance] <String> [-PfxLocalPath] <String>
 [-PfxPassword] <SecureString> [-RemoteFolder <String>] [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Used for installing certificates on SQL servers (clusters).

## EXAMPLES

### Example 1
```
PS C:\> $pass = Read-Host "Enter Password" -AsSecureString
PS C:\>  Install-SQLCertificate -ComputerName sqlsrv1 -SQLInstance DBNAME -PfxLocalPath C:\temp\DBDAME.pfx -PfxPassword $pass
```

Installs sql certificate on remote host sqlsrv1.
Requires reboot (cluster) or restart of service (standalone)

## PARAMETERS

### -ComputerName
Remote host to perform on.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Credential
Admin Credential to connect to remote host.

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

### -PfxLocalPath
Local path to Pfx file.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PfxPassword
PFX file password.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RemoteFolder
Remote folder to copy file to.
C:\windows\temp by default.

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

### -SQLInstance
Name of SQL instance to install cert to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

