@echo off

REM Sets Variable & And Pull Infro From File.
set /p version=<version.md
set /p verbose=<verbose.md

CLS
:MENU
ECHO.
ECHO *****************************************************************
ECHO ************** RXD - MODPACK - XTENDED **************************
ECHO ************ Source Version - %version% ***********************
ECHO *****************************************************************
ECHO.
ECHO Starting Source Code Compiler... %time%
ECHO.
ECHO ...................................................................
ECHO ..... PRESS 1, 2, 3, 4, c OR v to select your task, or e to EXIT .....
ECHO ...................................................................
ECHO.
ECHO 1 - Compile For PC - DX11
ECHO 2 - Compile For MOBILE - ASTC
ECHO 3 - Compile For MOBILE-EMBED - ASTC
ECHO 4 - Compile For Both ( PC - DX11 ) And ( MOBILE - ASTC )
ECHO c - Clean WwiseCache
ECHO v - Verbose Source Code Commits
ECHO e - EXIT
ECHO.
SET /P M=Type 1, 2, 3, 4, c, v or e then press ENTER:
ECHO.
IF %M%==1 GOTO DX11
IF %M%==2 GOTO ASTC
IF %M%==3 GOTO EMBED
IF %M%==4 GOTO ALL
IF %M%==c GOTO CLEAN
IF %M%==v GOTO VER
IF %M%==e GOTO EOF

:DX11

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For PC.

rd /s /q "pack\pc\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - PC!
ECHO.

timeout 5

REM Does Pack For PC Platform.

ECHO.
ECHO Copying Data To Pack-PC!
ECHO.

xcopy /s /y "src\*" "pack\pc\Data\"

ECHO.
ECHO Copyied Data To Pack-PC!
ECHO.

timeout 2

cd "pack\pc\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - DX11!
ECHO.

del /S "*.pvr"

ECHO.
ECHO Selected GPU Specific Textures - DX11!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplc.exe encode ./ --replace --force

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO ------------------------------------------

ECHO Finished Packaging Process For DX11!

ECHO ------------------------------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

GOTO MENU

:ASTC

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE.

rd /s /q "pack\mobile\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE!
ECHO.

timeout 5

REM Does Pack For MOBILE Platform.

ECHO.
ECHO Copying Data To Pack-MOBILE!
ECHO.

xcopy /s /y "src\*" "pack\mobile\Data\"

ECHO.
ECHO Copyied Data To Pack-MOBILE!
ECHO.

timeout 2

cd "pack\mobile\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

ECHO.
ECHO Selected GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplc.exe encode ./ --replace --force

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO ------------------------------------------

ECHO Finished Packaging Process For ASTC!

ECHO ------------------------------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

GOTO MENU

:VER

ECHO.

type verbose.md

ECHO.

GOTO MENU

:CLEAN

ECHO.
ECHO Cleaning WwiseCache!

del "src\WwiseSound\Init.bnk"
del "src\WwiseSound\*.json"
del "src\WwiseSound\*.xml"
rd /s /q "src\WwiseSound\English(US)\"

ECHO Cleaned WwiseCache!
ECHO.

GOTO MENU

:ALL

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For PC.

rd /s /q "pack\pc\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - PC!
ECHO.

timeout 5

REM Does Pack For PC Platform.

ECHO.
ECHO Copying Data To Pack - PC!
ECHO.

xcopy /s /y "src\*" "pack\pc\Data\"

ECHO.
ECHO Copyied Data To Pack - PC!
ECHO.

timeout 2

cd "pack\pc\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - DX11!
ECHO.

del /S "*.pvr"

ECHO Selected GPU Specific Textures - DX11!

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplc.exe encode ./ --replace --force

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO ------------------------------------------

ECHO Finished Packaging Process For DX11!

ECHO ------------------------------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE.

rd /s /q "pack\mobile\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE!
ECHO.

timeout 5

REM Does Pack For MOBILE Platform.

ECHO.
ECHO Copying Data To Pack - MOBILE!
ECHO.

xcopy /s /y "src\*" "pack\mobile\Data\"

ECHO.
ECHO Copyied Data To Pack - MOBILE!
ECHO.

timeout 2

cd "pack\mobile\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

ECHO.
ECHO Selected GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplc.exe encode ./ --replace --force

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO ------------------------------------------

ECHO Finished Packaging Process For ASTC!

ECHO ------------------------------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

GOTO MENU

:EMBED

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE-EMBED.

rd /s /q "pack\mobile-embed\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE-EMBED!
ECHO.

timeout 5

REM Does Pack For MOBILE-EMBED Platform.

ECHO.
ECHO Copying Data To Pack - MOBILE-EMBED!
ECHO.

xcopy /s /y "src\*" "pack\mobile-embed\Data\"

ECHO.
ECHO Copyied Data To Pack - MOBILE-EMBED!
ECHO.

timeout 2

cd "pack\mobile-embed\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

ECHO.
ECHO Selected GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplc.exe encode ./ --replace --force

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO Decoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplc.exe decode ./ --replace --force

ECHO.
ECHO Decoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO ------------------------------------------

ECHO Finished Packaging Process For ASTC!

ECHO ------------------------------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

GOTO MENU
