---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-PrintQueue.md
schema: 2.0.0
---

# Get-PrintQueue

## SYNOPSIS
Search through AD directory print queues to get information back.

## SYNTAX

```
Get-PrintQueue [[-QueueName] <Object>]
```

## DESCRIPTION
Helpful for finding servers that host print queues that need to be cleared.

## EXAMPLES

### Example 1
```
PS C:\> Get-PrintQueue | Export-Excel
```

Get List of all print queues and export to excel.

### Example 2
```
PS C:\> Get-PrintQueue -QueueName MainPrint_BW

```

Get infomation for one specific print queue.

## PARAMETERS

### -QueueName
Name of AD Print Queue.

```yaml
Type: Object
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

