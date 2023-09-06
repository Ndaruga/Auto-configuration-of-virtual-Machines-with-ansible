@echo off
cd /d "C:\Program Files\Oracle\VirtualBox"

setlocal
@REM set currentDir=%cd%
@REM echo %~dp0
:start
set /p vmName=Enter VM name to start: 
:loop
set /p startType="Enter the type of start. i.e (gui, headless, separate, sdl): "
echo.

:: Check the start type
if "%startType%"=="gui" (
    VBoxManage startvm %vmName% --type=gui
) else if "%startType%"=="headless" (
    VBoxManage startvm %vmName% --type=headless
) else if "%startType%"=="separate" (
    VBoxManage startvm %vmName% --type=separate
) else if "%startType%"=="sdl" (
    VBoxManage startvm %vmName% --type=sdl
) else (
    echo Invalid start type
    goto loop
)
echo.
set /p startVM=Would you like to start another VM? (Y/n)
if "%startVM%"=="y" (
    goto start
) else (
    echo.
)
