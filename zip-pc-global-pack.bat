@echo off

ECHO.
ECHO STARTING PACK COMPRESSION!
ECHO.

del ".\pack\pc\*.zip"

.\docs\7za.exe a -tzip -prxd-modpack-xtended-0907.2 .\pack\pc\rxd-modpack-xtended-pc-global.zip .\pack\pc\*

ECHO.
ECHO FINISHED PACK COMPRESSION!
ECHO.

@pause