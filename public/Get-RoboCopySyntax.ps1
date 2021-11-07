function Get-RoboCopySyntax {


    $fg = "black"
    $bg = "green"


Write-Host "====================================================" -foregroundcolor $fg -BackgroundColor $bg
Write-Host "=============WinOps Standard Robocopy Syntax========" -foregroundcolor $fg -BackgroundColor $bg
Write-Host "====================================================" -foregroundcolor $fg -BackgroundColor $bg

Write-Host "

robocopy <SOURCE> <DESTINATION> /ZB /DCOPY:T /COPY:DATS /MIR /R:3 /W:1 /NDL /NFL /MT:60 /LOG+:c:\temp\testing_%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%.txt /TEE


"
Write-Host "====================================================" -foregroundcolor $fg -BackgroundColor $bg
Write-Host "=============Explaination===========================" -foregroundcolor $fg -BackgroundColor $bg
Write-Host "====================================================" -foregroundcolor $fg -BackgroundColor $bg
Write-Host "
robocopy - the executable
Source  - location you are copying from
Destination - where the stuff is going
/ZB - Backup Mode
/DCOPY:T - Directory Copy
/COPY:DATS - Directory Attributes Timestamps Security
/MIR - Mirror
/R:3 - Retry attempts
/W:1 - Wait time between retry (1s)
/NDL - No directory names in log
/NFL - No file names in log
/MT:60 - Multithreads
/LOG+:c:\temp\testing_%DATE:~10,4%%DATE:~4,2%%DATE:~7,2%.txt - Log files location (includes time and date stamp)
/TEE - log and interactive display
/ETA -  Estimate time to be completed.

"





}
