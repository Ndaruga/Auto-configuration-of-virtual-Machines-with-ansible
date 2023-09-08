@echo off
cd /d "C:\Program Files\Oracle\VirtualBox"
setlocal enabledelayedexpansion

set /p vmName=Enter VM name to modify: 
echo WARNING: Modifying a Virtual Machine requires that the machine is powered off, neither running nor in a Saved state.
echo Power Off the VM %vmName% (Y/n)?
set /p choice=
if "%choice%" == "y" (
    VBoxManage controlvm %vmName% poweroff
) else (
    goto end
)

:options
cls
echo.
echo GENERAL VIRTUAL MACHINE SETTINGS
echo 1: Allocate amount of RAM
echo 2: Setting up a virtual hard drive
echo 3: Setting up and attaching the Installation Media (e.g., ISO)
echo.
set /p option=Enter an option:
echo.

if "%option%"=="1" goto RamMenu
if "%option%"=="2" goto HardDriveMenu
if "%option%"=="3" echo "Installation Media option not yet implemented" & pause & goto options

echo You entered an Invalid option.
pause
goto options

:RamMenu
cls
echo.
echo Menu:
echo 1. Set VM RAM to 512MB
echo 2. Set VM RAM to 1024MB
echo 3. Set VM RAM to 2048MB
echo 9. Custom RAM Size
echo 0. Exit to Main Menu
echo.
set /p ram=Select RAM option: 

if "%ram%"=="0" goto options
call :setRamSize %ram% %vmName%
goto RamMenu

:setRamSize
if "%1"=="1" (
    set ram_size=512
) else if "%1"=="2" (
    set ram_size=1024
) else if "%1"=="3" (
    set ram_size=2048
) else if "%1"=="9" (
    set /p ram_size=Enter custom RAM size in MB: 
) else (
    echo Invalid RAM option.
    pause
    goto RamMenu
)

VBoxManage modifyvm %2 --memory %ram_size%
if errorlevel 1 (
    echo Error modifying memory of %2.
    pause
    goto RamMenu
) else (
    echo Memory of %2 modified to %ram_size%MB successfully!
    pause
    goto RamMenu
)

:HardDriveMenu


:end
exit /b
