@echo off
cd /d "C:\Program Files\Oracle\VirtualBox"

setlocal
set /p vmName=Enter VM name to modify: 
echo WARNING: Modifying a Virtual Machine require that the machine is powered off, neither running nor in a Saved state
echo Power Off the VM %vmName% (Y/n)
set /p choice=
if "%choice%" == "y" (
    VBoxManage controlvm %vmName% poweroff
) else (
    goto end
)

:end
echo.
echo GENERAL VIRTUAL MACHINE SETTINGS
echo 1: Allocate amount of RAM
echo 2: Setting up a virtual hard drive
echo 2: Setting up and attaching the Installation Media (e.g., ISO)

echo.

set /p option=Enter an option:
echo.

:: Check the option and run the corresponding command
if "%option%"=="1" (
    set /p ram=Enter amount of RAM in MBs: 
    VBoxManage modifyvm %vmName% --memory %ram%
    
) else if "%option%"=="2" (
    echo Registered VMs
    VBoxManage list -s vms
) else if "%option%"=="3" (
    echo Running VMs
    VBoxManage list runningvms
) else if "%option%"=="4" (
    VBoxManage list ostypes
) else if "%option%"=="5" (
    call %~dp0createvm.bat
) else if "%option%"=="6" (
    call %~dp0modifyVM.bat
) else if "%option%"=="7" (
    call %~dp0startvm.bat
) else if "%option%"=="8" (
    call %~dp0controlVM.bat
) else (
    echo You entered an Invalid option
)

pause