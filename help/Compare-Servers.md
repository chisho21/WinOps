---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Compare-Servers.md
schema: 2.0.0
---

# Compare-Servers

## SYNOPSIS
Collect a category of info from two remote hosts for comparison.

## SYNTAX

```
Compare-Servers [-Server1] <Object> [-Server2] <Object> [[-DataSet] <Object>] [-RawDataOnly]
 [-Server1Credential <PSCredential>] [-Server2Credential <PSCredential>] [<CommonParameters>]
```

## DESCRIPTION
Collect a category of info from two remote hosts for comparison.
Made to answer the question: "Why are these servers different?"

## EXAMPLES

### Example 1
```
PS C:\> Compare-Servers server01 server02 -Verbose
                                                                  
VERBOSE: Collecting data for server01 and server02 :: Data Type - SystemInfo                         
VERBOSE: Formatting data for server01 and server02 :: Data Type - SystemInfo
                              
                                           
DataSet      : SystemInfo            
Property     : BIOSVersion      
Status       : Equal              
server01 : PhoenixBIOS 4.0 Release 6.0      (INTEL  - 6040000)
server02 : PhoenixBIOS 4.0 Release 6.0      (INTEL  - 6040000)
                
DataSet      : SystemInfo       
Property     : ComputerName
Status       : Diff                                      
server01 : server02   
server02 : server01                
                                     
DataSet      : SystemInfo       
Property     : Cutover             
Status       : Equal                    
server01 :                          
server02 :
```

Compare two servers SystemInfo.

## PARAMETERS

### -DataSet
Predefined Dataset to gather.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:
Accepted values: SystemInfo, Services, Features, Programs, HotFixes

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server1
Name of Server1

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Server2
Name of Server1

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -RawDataOnly
Return Data only without comparisons.

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

### -Server1Credential
Admin Credential for Server1

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

### -Server2Credential
Admin Credential for Server2

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

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

