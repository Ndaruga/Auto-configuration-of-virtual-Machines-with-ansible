@echo off

setlocal
echo WELCOME TO CONFIGURATION OF VIRTUAL MACHINES
echo.
:: Change the path below to the path where virtualbox is installed
cd /d "C:\Program Files\Oracle\VirtualBox"
:: check version
for /f %%i in (VBoxManage --version') do set "version=%%i"
echo Your VirtualBox version is: %version%
echo.

:start
:: Prompt the user to enter an option
echo.
echo What would you like to do? Please enter the option number from the available options below:
echo.
echo 1. Show the host OS information
echo 2: List All Registered VMs
echo 3: List the current Running VMs
echo 4: Lists all installable guest operating systems
echo 5: Create a new Virtual Machine
echo 6: Modify a Virtual Machine
echo 7: Start a Virtual Machine

echo.

set /p option=Enter an option:
echo.

:: Check the option and run the corresponding command
if "%option%"=="1" (
    VBoxManage list hostinfo
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
) else (
    echo You entered an Invalid option
)



@REM Prompt the user to exit or continue
echo.
echo Do you want to EXIT? (Y/n)
set /p choice=

if "%choice%" == "y" (
    exit
) else (
    goto start
)

pause