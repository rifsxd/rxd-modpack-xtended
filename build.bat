@echo off

REM Sets Variable & And Pull Infro From File.
set /p version=<version.md

ECHO ****************************************************
ECHO ************** RXD - MODPACK - XTENDED *************
ECHO ************ Source Version - %version% ************
ECHO ****************************************************
ECHO Starting Source Code Packaging!

timeout -1

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache.

rd /s /q "pack\pc\Data\" && rd /s /q "pack\mobile\Data\"

ECHO Cleaned Cache Data For Pack - PC - MOBILE!

timeout 5

REM Does Pack For PC Platform.

ECHO Copying Data To Pack-PC!

xcopy /s /y "src\*" "pack\pc\Data\"

ECHO Copyied Data To Pack-PC!

timeout 2

cd "pack\pc\Data\"

ECHO Selecting GPU Specific Textures - DX11!

del /S "*.pvr"

ECHO Selected GPU Specific Textures - DX11!

timeout 2

ECHO Encoding To LZ4 Compression - DVPL!

..\..\..\bin\dvpl.exe cp

ECHO Encoded To LZ4 Compression - DVPL!

timeout 2

REM Does Fallback To Source Path.

cd "../../.."

REM Does Pack For MOBILE Platform.

ECHO Copying Data To Pack-MOBILE!

xcopy /s /y "src\*" "pack\mobile\Data\"

ECHO Copyied Data To Pack-MOBILE!

timeout 2

cd "pack\mobile\Data\"

ECHO Selecting GPU Specific Textures - ASTC!

del /S "*.dds"

ECHO Selected GPU Specific Textures - ASTC!

timeout 2

ECHO Encoding To LZ4 Compression - DVPL!

..\..\..\bin\dvpl.exe cp

ECHO Encoded To LZ4 Compression - DVPL!

ECHO ------------------------------------------

ECHO Finished Packaging Process!

ECHO ------------------------------------------

@pause