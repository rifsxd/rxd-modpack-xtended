@echo off

ECHO.
ECHO STARTING PACK COMPRESSION!
ECHO.

del ".\pack\mobile-lesta\*.zip"

.\docs\7za.exe a -tzip -prxd-modpack-xtended-0907.2 .\pack\mobile-lesta\rxd-modpack-xtended-mobile-lesta-center.zip .\pack\mobile-lesta\*

ECHO.
ECHO FINISHED PACK COMPRESSION!
ECHO.

@pause