---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-LocalAdminInfo.md
schema: 2.0.0
---

# Get-LocalAdminInfo

## SYNOPSIS
Retrieve info from remote machine about local admin account.

## SYNTAX

```
Get-LocalAdminInfo [-ComputerName] <Object> [-UserName <String>] [-SID <String>] [-Credential <PSCredential>]
 [<CommonParameters>]
```

## DESCRIPTION
Retrieve info from remote machine about local admin account.
Searches for default SID unless accountname is specified.
Useful for checking on password changes.

## EXAMPLES

### Example 1
```
PS C:\> Get-LocalAdminInfo server01


ComputerName           : server01
Name                   : Administrator
Enabled                : True
PasswordLastSet        : 10/7/2020 1:29:22 PM
LastLogon              : 10/7/2020 1:29:59 PM
AccountExpires         :
PasswordChangeableDate : 10/9/2020 1:29:22 PM
PasswordExpires        : 1/5/2021 12:29:22 PM
Description            : Built-in account for administering the computer/domain
FullName               :
UserMayChangePassword  : True
PasswordRequired       : True
SID                    : 
DataTimeStamp          : 10/9/2020 2:19:48 PM
PSComputerName         : server01
```

Getlocal admin info for server01

## PARAMETERS

### -ComputerName
Remote Host to Check on.

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
Admin Credential for remote host.

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

### -SID
Look for a specific SID.
By Default searches for S-1-5-21-*-500

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
Specify a username instead of default SID.

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

