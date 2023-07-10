@echo off

REM Sets Variable & And Pull Info From File.

REM Commenting Unused Code setlocal EnableExtensions EnableDelayedExpansion

set /p version=<version.md
set /p verbose=<verbose.md
set versioning=version.md
set modv=xtendedmodversion.txt
set build=buildtime.txt

TITLE XTENDED - COMPILER %version%

CLS

:MENU
ECHO.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
ECHO.
ECHO *****************************************************************
ECHO ************** RXD - MODPACK - XTENDED **************************
ECHO ************ Source Version - %version% ***********************
ECHO ***************************************************************** 
ECHO.
ECHO Starting Source Code Compiler... %time%
ECHO.
ECHO .........................................................................
ECHO ..... PRESS 1, 2, 3, 4, 5, c OR v to select your task, or e to EXIT .....
ECHO .........................................................................
ECHO.
ECHO 1 - Compile For PC - DX11
ECHO 2 - Compile For MOBILE - ASTC
ECHO 3 - Compile For MOBILE - Lesta - ASTC
ECHO 4 - Compile For MOBILE-EMBED - ASTC
ECHO 5 - Compile For All ( PC - DX11 ) , ( MOBILE - ASTC ) , ( MOBILE - Lesta - ASTC ) And ( MOBILE-EMBED - ASTC )
ECHO w - Include Wwise Bank Files To Source
ECHO v - Verbose Source Code Commits
ECHO e - EXIT
ECHO.
SET /P "M=Type 1, 2, 3, 4, 5, c, v or e then press ENTER: "
ECHO.
IF "%M%" EQU "" GOTO ERROR
IF "%M%" EQU "1" GOTO DX11
IF "%M%" EQU "2" GOTO ASTC
IF "%M%" EQU "3" GOTO ASTC-LESTA
IF "%M%" EQU "4" GOTO EMBED
IF "%M%" EQU "5" GOTO ALL
IF "%M%" EQU "w" GOTO WWISE
IF "%M%" EQU "v" GOTO VER
IF "%M%" EQU "e" GOTO EOF


:ERROR

ECHO.
ECHO Invalid Input! Choose Correctly -,- 
ECHO.

@pause

GOTO MENU

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
ECHO --------------------X----------------------

ECHO Finished Packaging Process For DX11!

ECHO --------------------X----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/pc/data/%modv%

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
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

del /S "*.pvr"


ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "keyart*.webp"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
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
ECHO --------------------X----------------------

ECHO Finished Packaging Process For ASTC!

ECHO --------------------X----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/mobile/data/%modv%

GOTO MENU

:VER

ECHO.

type verbose.md

ECHO.

GOTO MENU

:WWISE

ECHO.
ECHO Including Wwise Bank Files To SOURCE!
ECHO.

del /S "cache\Init.bnk"

xcopy /s /y  "cache\*.bnk" "src\WwiseSound\"

ECHO.
ECHO Included Wwise Bank Files  To SOURCE!
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
ECHO --------------------+----------------------

ECHO Finished Packaging Process For DX11!

ECHO --------------------+----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../..

type .\%versioning% > ./pack/pc/data/%modv%

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
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

del /S "*.pvr"

ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "keyart*.webp"

rd /s /q "UI"

ECHO.
ECHO Cleaned Embed Specific Configs!
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
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC!

ECHO --------------------+----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/mobile/data/%modv%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE - Lesta.

rd /s /q "pack\mobile-lesta\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE - Lesta!
ECHO.

timeout 5

REM Does Pack For MOBILE - Lesta Platform.

ECHO.
ECHO Copying Data To Pack-MOBILE!
ECHO.

xcopy /s /y "src\*" "pack\mobile-lesta\Data\"

ECHO.
ECHO Copyied Data To Pack-MOBILE - Lesta!
ECHO.

timeout 2

cd "pack\mobile-lesta\Data\"

ECHO.
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

del /S "*.pvr"

ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "keyart*.webp"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
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
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC - Lesta!

ECHO --------------------+----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/mobile-lesta/data/%modv%

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
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC-EMBED!

ECHO --------------------+----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/mobile-embed/data/%modv%

ECHO.
ECHO --------------------X----------------------

ECHO Finished Packaging Process For All!

ECHO --------------------X----------------------
ECHO.

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
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC-EMBED!

ECHO --------------------+----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/mobile-embed/data/%modv%

GOTO MENU

:ASTC-LESTA

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE - Lesta.

rd /s /q "pack\mobile-lesta\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE - Lesta!
ECHO.

timeout 5

REM Does Pack For MOBILE - Lesta Platform.

ECHO.
ECHO Copying Data To Pack-MOBILE!
ECHO.

xcopy /s /y "src\*" "pack\mobile-lesta\Data\"

ECHO.
ECHO Copyied Data To Pack-MOBILE - Lesta!
ECHO.

timeout 2

cd "pack\mobile-lesta\Data\"

ECHO.
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*.dds"

del /S "*.pvr"

ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "keyart*.webp"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
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
ECHO --------------------X----------------------

ECHO Finished Packaging Process For ASTC - Lesta!

ECHO --------------------X----------------------
ECHO.

powershell date > ./%build%

REM Does Fallback To Source Path.

cd "../../.."

type .\%versioning% > ./pack/mobile-lesta/data/%modv%

GOTO MENU