@echo off

color 0c

REM Sets Variable & And Pull Info From File.

REM Commenting Unused Code setlocal EnableExtensions EnableDelayedExpansion

set /p version=<version.md
set /p verbose=<verbose.md
set versioning=version.md
set /p vbuild=<build.md
set build=build.md

set modv=xtended_wot_mod_version.txt
set buildtxt=xtendedbuild.txt
set /p version=<version.txt

set /a sum=%vbuild%+1


TITLE XTENDED - COMPILER %version%

CLS

:MENU

color 0c

ECHO.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
ECHO.
ECHO *****************************************************************
ECHO **************** RXD - MODPACK - XTENDED - WOT ******************
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
ECHO a - Compile For All ( PC - DX11 ) , ( MOBILE - ASTC ) , ( MOBILE - Lesta - ASTC ) And ( MOBILE-EMBED - ASTC )
ECHO w - Include Wwise Bank Files To Source
ECHO v - Verbose Source Code Commits ( Quick Tip - Press 'Q' to exit logs! )
ECHO e - EXIT
ECHO.
SET /P "M=Type 1, 2, 3, 4, a, w, v or e then press ENTER: "
ECHO.
IF "%M%" EQU "" GOTO ERROR
IF "%M%" EQU "1" GOTO DX11
IF "%M%" EQU "2" GOTO ASTC
IF "%M%" EQU "3" GOTO ASTC-LESTA
IF "%M%" EQU "4" GOTO EMBED
IF "%M%" EQU "a" GOTO ALL
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


(
echo %sum%
echo.
echo %version%
powershell date
) > %build%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For PC.

rd /s /q "pack_wot\pc\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - PC!
ECHO.

timeout 5

REM Does Pack For PC Platform.

ECHO.
ECHO Copying Data To Pack-PC!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\pc\Data\"

ECHO.
ECHO Copyied Data To Pack-PC!
ECHO.

timeout 2

cd "pack_wot\pc\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - DX11!
ECHO.

del /S "*astc.pvr"

ECHO.
ECHO Selected GPU Specific Textures - DX11!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------X----------------------

ECHO Finished Packaging Process For DX11!

ECHO --------------------X----------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/pc/data/%modv%

GOTO MENU

:ASTC

(
echo %sum%
echo.
echo %version%
powershell date
) > %build%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE.

rd /s /q "pack_wot\mobile\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE!
ECHO.

timeout 5

REM Does Pack For MOBILE Platform.

ECHO.
ECHO Copying Data To Pack-MOBILE!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\mobile\Data\"

ECHO.
ECHO Copyied Data To Pack-MOBILE!
ECHO.

timeout 2

cd "pack_wot\mobile\Data\"

ECHO.
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*dx11.dds"


ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "rxd_LBG*.webp"

del /S "*.json"

del /S "Init.bnk"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
ECHO.

xcopy /s /y "..\..\..\src_wot\3d\*.yaml" "3d\"

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------X----------------------

ECHO Finished Packaging Process For ASTC!

ECHO --------------------X----------------------
ECHO.


REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/mobile/data/%modv%

GOTO MENU

:VER

ECHO.

git log >nul 2>&1 && ( git log ) || ( echo You need Git installed for this command to work! )

ECHO.

GOTO MENU

:WWISE

ECHO.
ECHO Including Wwise Bank Files To SOURCE!
ECHO.

del /S "cache_wot\Init.bnk"

xcopy /s /y  "cache_wot\*.bnk" "src_wot\WwiseSound\"

ECHO.
ECHO Included Wwise Bank Files  To SOURCE!
ECHO.

GOTO MENU

:ALL

(
echo %sum%
echo.
echo %version%
powershell date
) > %build%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For PC.

rd /s /q "pack_wot\pc\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - PC!
ECHO.

timeout 5

REM Does Pack For PC Platform.

ECHO.
ECHO Copying Data To Pack - PC!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\pc\Data\"

ECHO.
ECHO Copyied Data To Pack - PC!
ECHO.

timeout 2

cd "pack_wot\pc\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - DX11!
ECHO.

del /S "*astc.pvr"

ECHO.
ECHO Selected GPU Specific Textures - DX11!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------+----------------------

ECHO Finished Packaging Process For DX11!

ECHO --------------------+----------------------
ECHO.


REM Does Fallback To Source Path.

cd "../../..

type .\%build% > ./pack/pc/data/%modv%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE.

rd /s /q "pack_wot\mobile\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE!
ECHO.

timeout 5

REM Does Pack For MOBILE Platform.

ECHO.
ECHO Copying Data To Pack - MOBILE!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\mobile\Data\"

ECHO.
ECHO Copyied Data To Pack - MOBILE!
ECHO.

timeout 2

cd "pack_wot\mobile\Data\"

ECHO.
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*dx11.dds"

ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "rxd_LBG*.webp"

del /S "*.json"

del /S "Init.bnk"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
ECHO.

xcopy /s /y "..\..\..\src_wot\3d\*.yaml" "3d\"

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC!

ECHO --------------------+----------------------
ECHO.


REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/mobile/data/%modv%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE - Lesta.

rd /s /q "pack_wot\mobile-lesta\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE - Lesta!
ECHO.

timeout 5

REM Does Pack For MOBILE - Lesta Platform.

ECHO.
ECHO Copying Data To Pack-MOBILE!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\mobile-lesta\Data\"

ECHO.
ECHO Copyied Data To Pack-MOBILE - Lesta!
ECHO.

timeout 2

cd "pack_wot\mobile-lesta\Data\"

ECHO.
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*dx11.dds"

ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "rxd_LBG*.webp"

del /S "*.json"

del /S "Init.bnk"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
ECHO.

xcopy /s /y "..\..\..\src_wot\3d\*.yaml" "3d\"

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC - Lesta!

ECHO --------------------+----------------------
ECHO.

REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/mobile-lesta/data/%modv%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE-EMBED.

rd /s /q "pack_wot\mobile-embed\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE-EMBED!
ECHO.

timeout 5

REM Does Pack For MOBILE-EMBED Platform.

ECHO.
ECHO Copying Data To Pack - MOBILE-EMBED!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\mobile-embed\Data\"

ECHO.
ECHO Copyied Data To Pack - MOBILE-EMBED!
ECHO.

timeout 2

cd "pack_wot\mobile-embed\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - ASTC!
ECHO.

del /S "*dx11.dds"

ECHO.
ECHO Selected GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO Decoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe dcp

color 0c

ECHO.
ECHO Decoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC-EMBED!

ECHO --------------------+----------------------
ECHO.


REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/mobile-embed/data/%modv%

ECHO.
ECHO --------------------X----------------------

ECHO Finished Packaging Process For All!

ECHO --------------------X----------------------
ECHO.

GOTO MENU

:EMBED

(
echo %sum%
echo.
echo %version%
powershell date
) > %build%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE-EMBED.

rd /s /q "pack_wot\mobile-embed\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE-EMBED!
ECHO.

timeout 5

REM Does Pack For MOBILE-EMBED Platform.

ECHO.
ECHO Copying Data To Pack - MOBILE-EMBED!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\mobile-embed\Data\"

ECHO.
ECHO Copyied Data To Pack - MOBILE-EMBED!
ECHO.

timeout 2

cd "pack_wot\mobile-embed\Data\"

ECHO.
ECHO Selecting GPU Specific Textures - ASTC!
ECHO.

del /S "*dx11.dds"

ECHO.
ECHO Selected GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO Decoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe dcp

color 0c

ECHO.
ECHO Decoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------+----------------------

ECHO Finished Packaging Process For ASTC-EMBED!

ECHO --------------------+----------------------
ECHO.


REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/mobile-embed/data/%modv%

GOTO MENU

:ASTC-LESTA

(
echo %sum%
echo.
echo %version%
powershell date
) > %build%

ECHO ------------------------------------------

REM Does Cleaning Of Old Cache For MOBILE - Lesta.

rd /s /q "pack_wot\mobile-lesta\Data\"

ECHO.
ECHO Cleaned Cache Data For Pack - MOBILE - Lesta!
ECHO.

timeout 5

REM Does Pack For MOBILE - Lesta Platform.

ECHO.
ECHO Copying Data To Pack-MOBILE!
ECHO.

xcopy /s /y "src_wot\*" "pack_wot\mobile-lesta\Data\"

ECHO.
ECHO Copyied Data To Pack-MOBILE - Lesta!
ECHO.

timeout 2

cd "pack_wot\mobile-lesta\Data\"

ECHO.
ECHO Clearing Unused GPU Specific Textures - ASTC!
ECHO.

del /S "*dx11.dds"

ECHO.
ECHO Cleared Unused GPU Specific Textures - ASTC!
ECHO.

timeout 2

ECHO.
ECHO Cleaning Embed Specific Configs!
ECHO.

del /S "*.yaml"

del /S "rxd_LBG*.webp"

del /S "*.json"

del /S "Init.bnk"

rd /s /q "UI"


ECHO.
ECHO Cleaned Embed Specific Configs!
ECHO.

xcopy /s /y "..\..\..\src_wot\3d\*.yaml" "3d\"

timeout 2

ECHO.
ECHO Encoding To LZ4 Compression - DVPL!
ECHO.

..\..\..\bin\dvplgo.exe cp

color 0c

ECHO.
ECHO Encoded To LZ4 Compression - DVPL!
ECHO.

ECHO.
ECHO --------------------X----------------------

ECHO Finished Packaging Process For ASTC - Lesta!

ECHO --------------------X----------------------
ECHO.


REM Does Fallback To Source Path.

cd "../../.."

type .\%build% > ./pack/mobile-lesta/data/%modv%

GOTO MENU