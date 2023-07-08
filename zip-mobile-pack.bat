@echo off

del ".\pack\mobile\*.zip"

.\docs\7za.exe a -tzip -prxd-modpack-xtended-0907 .\pack\mobile\rxd-modpack-xtended-mobile-google-play.zip .\pack\mobile\*