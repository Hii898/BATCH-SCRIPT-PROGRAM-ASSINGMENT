@echo off
title Network Status Report
setlocal EnableDelayedExpansion

set "INPUT=network_info.txt"
set "OUTPUT=report.txt"

if not exist "%INPUT%" (
    echo ERROR: %INPUT% was not found.
    echo Run network_check.bat first.
    pause
    exit /b 1
)

echo ==========================================
echo          NETWORK STATUS REPORT
echo ==========================================
echo.

echo Generating report...

(
echo ==========================================
echo           NETWORK STATUS REPORT
echo ==========================================
echo.
echo Generated Date: %date%
echo Generated Time: %time%
echo.
echo ------------------------------------------
echo ORIGINAL NETWORK INFORMATION
echo ------------------------------------------
echo.

type "%INPUT%"

echo.
echo ------------------------------------------
echo ANALYSIS
echo ------------------------------------------
echo.

findstr /I /C:"TTL=" "%INPUT%" >nul
if errorlevel 1 (
    echo Connectivity Status: OFFLINE or FAILED
) else (
    echo Connectivity Status: ONLINE
)

echo.

findstr /I /C:"IP ADDRESS:" "%INPUT%" >nul
if errorlevel 1 (
    echo IP Address: Not detected
) else (
    echo IP Address: Detected
)

findstr /I /C:"SUBNET MASK:" "%INPUT%" >nul
if errorlevel 1 (
    echo Subnet Mask: Not detected
) else (
    echo Subnet Mask: Detected
)

findstr /I /C:"MAC ADDRESS:" "%INPUT%" >nul
if errorlevel 1 (
    echo MAC Address: Not detected
) else (
    echo MAC Address: Detected
)

echo.
echo ------------------------------------------
echo END OF REPORT
echo ------------------------------------------

) > "%OUTPUT%"

echo.
echo Report successfully created: %OUTPUT%
echo.
type "%OUTPUT%"
pause
