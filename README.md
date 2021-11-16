# WinOps
PSModule For Windows/AD Administration

## Install and Setup
Install from the PSGallery:
```
Install-Module WinOps -Scope CurrentUser
```

To handle saving credential objects:
```
Install-Module PSCredVault -Scope CurrentUser
```
## History
A few years ago I took the challenge to perform all daily duties from a remote shell. Everytime that I (or a teammate) had to logon via RDP to look at something, we added that scenario to a backlog and slowly added to the list. Some commands are actually wrappers for regular cmd commands (netstat, tasksch, etc.).

## Behind the Scenes
I've worked with and created modules before, but I've never pushed one to the powershellgallery. My github repo is setup to Run PSScriptAnalyzer against any commit and upon the creation of a release, it will publish the module to powershellgallery.

## Useful/Interesting Commands
Get-List - Paste a list into your shell, instead of having to call a .txt file. Easily my most used command working with lists of servers or users all the time.

Get-Table - Paste a table from excel into your shell and store as a pscustomobject.

Compare-Servers - Useful for troubleshooting why something works on one server and not the other.

Get-GPResult - Get an RSOP report from a remote machine even if you've never logged on to it.

Get-PortCertificate - stolen from someone else but useful for identifying machines where you only have an IP and no reverse DNS record.

Get-Htop - Get performance info via graph for remote machines.

Get-SChannelInfo - Useful for hunting down the info that IISCrypto will give you.

## Room for improvement
- Designed to run remotely, somecommands work locally, but need a refactor to get away form $using: variables.

Links
[Github Repo](https://github.com/chisho21/WinOps)

[PowerShell Gallery Package](https://www.powershellgallery.com/packages/WinOps/0.10.0)
