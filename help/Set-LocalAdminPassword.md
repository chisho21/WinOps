---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Set-LocalAdminPassword.md
schema: 2.0.0
---

# Set-LocalAdminPassword

## SYNOPSIS
Set local admin password on remote host.

## SYNTAX

```
Set-LocalAdminPassword [-ComputerName] <Object> [-NewPassword <String>] [-UserName <String>] [-SID <String>]
 [-Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Set local admin password on remote host.

## EXAMPLES

### Example 1
```
PS C:\> Set-LocalAdminPassword server01


ComputerName           : server01
Name                   : Administrator
Enabled                : True
PasswordLastSet        : 10/9/2020 2:24:06 PM
LastLogon              : 10/7/2020 1:29:59 PM
AccountExpires         :
PasswordChangeableDate : 10/11/2020 2:24:06 PM
PasswordExpires        : 1/7/2021 1:24:06 PM
Description            : Built-in account for administering the computer/domain
FullName               :
UserMayChangePassword  : True
PasswordRequired       : True
SID                    : S-1-5-21-3036322720-3574479-2638832519-500
DataTimeStamp          : 10/9/2020 2:24:06 PM
PSComputerName         : server01
RunspaceId             : 411e41dd-fb5d-4135-823c-8ba110e3d353

Local Admin password(s) has been changed to: Ch@ng3m3n0w!!
```

Set new local admin pass using default settings.

## PARAMETERS

### -ComputerName
Remote host to perform on.

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
Admin credential for remote host.

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

### -NewPassword
New Password.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: "Ch@ng3m3n0w!!"
Accept pipeline input: False
Accept wildcard characters: False
```

### -SID
Alternative SID.
Default is S-1-5-21-*-500

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

### -UserName
Choose account to act on if not default SID.

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

### System.Object
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

