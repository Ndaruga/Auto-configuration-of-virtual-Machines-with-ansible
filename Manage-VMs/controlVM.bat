@echo off
cd /d "C:\Program Files\Oracle\VirtualBox"

setlocal
@REM set currentDir=%cd%
@REM echo %~dp0
:start
set /p vmName=Enter VM name to control: 
:loop
set /p ctrl="Enter the type of control. i.e (pause, resume, reset, savestate, poweroff): "
echo.

:: Check the control type
if "%ctrl%"=="pause" (
    VBoxManage controlvm %vmName% pause
) else if "%ctrl%"=="resume" (
    VBoxManage controlvm %vmName% resume
) else if "%ctrl%"=="reset" (
    VBoxManage controlvm %vmName% reset
) else if "%ctrl%"=="savestate" (
    VBoxManage controlvm %vmName% savestate
) else if "%ctrl%"=="poweroff" (
    echo Powering off %vmName%
    VBoxManage controlvm %vmName% poweroff
) else (
    echo Invalid control type
    goto loop
)
echo.
set /p startVM=Would you like to control another VM? (Y/n)
if "%startVM%"=="y" (
    goto start
) else (
    echo.
)
