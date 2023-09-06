@echo off
cd /d "C:\Program Files\Oracle\VirtualBox"

setlocal
@REM set currentDir=%cd%
@REM echo %~dp0
:start
echo.
set /p vmName=Enter VM name to control: 
:loop
set /p ctrl="Enter the type of control. i.e (pause, resume, reset, savestate, poweroff): "
echo.

:: Check the control type
if "%ctrl%"=="pause" (
    VBoxManage controlvm %vmName% pause
    echo %vmName% paused successfully
) else if "%ctrl%"=="resume" (
    echo Resuming previous %vmName% state
    VBoxManage controlvm %vmName% resume
) else if "%ctrl%"=="reset" (
    echo Resettin %vmName%
    VBoxManage controlvm %vmName% reset
) else if "%ctrl%"=="savestate" (
    VBoxManage controlvm %vmName% savestate
    echo Current %vmName% state saved successfully
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
