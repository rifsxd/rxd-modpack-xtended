@echo off
ECHO Decoding To LZ4 Compression - DVPL!
cd "src\" && ..\bin\dvplc.exe decode ./ --replace --force
@pause