@echo off

ECHO.
ECHO STARTING PACK COMPRESSION!
ECHO.

del ".\pack\mobile\*play.zip"

.\docs\7za.exe a -tzip -prxd-modpack-xtended-0907.2 .\pack\mobile\rxd-modpack-xtended-mobile-google-play.zip .\pack\mobile\*

ECHO.
ECHO FINISHED PACK COMPRESSION!
ECHO.

@pause