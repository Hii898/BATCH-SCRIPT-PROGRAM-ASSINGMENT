@echo off
title Network Information Collector
setlocal EnableDelayedExpansion

echo ==========================================
echo       NETWORK INFORMATION COLLECTOR
echo ==========================================
echo.

set /p TARGET=Enter IP address or hostname to check:

echo.
echo Checking connectivity to %TARGET%...
ping -n 1 -w 2000 %TARGET% >nul

if errorlevel 1 (
    echo [OFFLINE] %TARGET% is not reachable.
) else (
    echo [ONLINE] %TARGET% is reachable.
)

echo.
echo Collecting network information...

set "REPORT=network_info.txt"

echo NETWORK INFORMATION REPORT > "%REPORT%"
echo ========================== >> "%REPORT%"
echo Date: %date% >> "%REPORT%"
echo Time: %time% >> "%REPORT%"
echo. >> "%REPORT%"
echo TARGET: %TARGET% >> "%REPORT%"
echo. >> "%REPORT%"

echo IP ADDRESS: >> "%REPORT%"
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /C:"IPv4 Address"') do (
    set "IP=%%A"
    set "IP=!IP: =!"
    echo !IP! >> "%REPORT%"
)

echo. >> "%REPORT%"
echo SUBNET MASK: >> "%REPORT%"
for /f "tokens=2 delims=:" %%A in ('ipconfig ^| findstr /C:"Subnet Mask"') do (
    set "MASK=%%A"
    set "MASK=!MASK: =!"
    echo !MASK! >> "%REPORT%"
)

echo. >> "%REPORT%"
echo MAC ADDRESS: >> "%REPORT%"
for /f "tokens=1" %%A in ('getmac /fo table /nh ^| findstr /R "[0-9A-F][0-9A-F]-"') do (
    echo %%A >> "%REPORT%"
)

echo. >> "%REPORT%"
echo CONNECTIVITY STATUS: >> "%REPORT%"
ping -n 1 -w 2000 %TARGET% >> "%REPORT%"

echo.
echo Information saved to %REPORT%.
echo.
echo Email sending requires your SMTP server and credentials.
echo This script does not store or transmit passwords.
pause
