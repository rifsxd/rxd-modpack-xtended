@echo off
ECHO Encoding To LZ4 Compression - DVPL!
cd "src\" && ..\bin\dvplc.exe encode ./ --replace --force
@pause