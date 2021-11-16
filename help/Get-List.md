---
external help file: WinOps-help.xml
Module Name: WinOps
online version: https://github.com/chisho21/WinOps/help/Get-List.md
schema: 2.0.0
---

# Get-List

## SYNOPSIS
Allows user to paste an ad-hoc list into PowerShell and store as $list.

## SYNTAX

```
Get-List
```

## DESCRIPTION
Allows user to paste an ad-hoc list into PowerShell and store as $list.

## EXAMPLES

### Example 1
```
PS C:\> Get-List
Paste your list below with each item on its own line
Server01
Server02
Server03

6 items have been added to variable $ list
PS H:\> $list | foreach {Get-AdComputer $_} | select name,Enabled | FT -AutoSize

name           Enabled
----           -------
Server01      True
Server02      True
Server03      True

```

Get ad-hoc list and use for a foreach loop to get AD information on all.

## PARAMETERS

## INPUTS

### None
## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

