@echo off

NET SESSION >nul 2>&1
if %errorlevel% EQU 0 (
    echo This script is running with administrator privileges. Continuing...
) else (
    echo This script is not running with administrator privileges. Exiting...
    pause
    exit /B 1
)


if "%1"=="disable" (
    echo Disabling windows update
    echo Adding 1 scheduled task: "Disable Windows Update"
    schtasks /create /tn "Disable Windows Update" /tr "net stop wuauserv" /sc MINUTE /mo 15 /ru SYSTEM
    schtasks /run /tn "Disable Windows Update"
) else (
    if "%1"=="enable" (
        echo Enabling windows update
        schtasks /change /TN "Disable Windows Update" /disable
        net start wuauserv
        
    ) else (
        echo Usage: %0 [disable ^| enable]
    )
)