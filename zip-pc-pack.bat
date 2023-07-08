@echo off

del ".\pack\pc\*.zip"

.\docs\7za.exe a -tzip -prxd-modpack-xtended-0907 .\pack\pc\rxd-modpack-xtended-pc-global.zip .\pack\pc\*