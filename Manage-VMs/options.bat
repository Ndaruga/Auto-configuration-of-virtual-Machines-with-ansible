@echo off

setlocal
echo WELCOME TO CONFIGURATION OF VIRTUAL MACHINES
echo.
:: Change the path below to the path where virtualbox is installed
cd /d "C:\Program Files\Oracle\VirtualBox"
:: check version
for /f %%i in ('VBoxManage --version') do set "version=%%i"
echo Your VirtualBox version is: %version%
echo.

:start
:: Prompt the user to enter an option
echo.
echo What would you like to do? Please enter the option number from the available options below:
echo.
echo 1: List All Registered VMs
echo 2: List Running VMs
echo 4: Enable Nested VT-x/AMD-v of a VM
echo 5: Show VM Info
echo 6: Modify the amount of RAM assigned to a VM
echo 7: Modify the number of Virtual CPUs assigned to a VM
echo 8: Start a VM
echo 9: Power Off a VM
echo 10: Pause a VM
echo 11: Resume a VM
echo 12: Save the Current State of a VM
echo 13: Reset a VM
echo 14: Check Available OS Types
echo.

set /p option=Enter an option:
echo.

:: Check the option and run the corresponding command
if "%option%"=="1" (
    echo Registered VMs
    VBoxManage list -s vms
) else if "%option%"=="2" (
    echo Running VMs
    VBoxManage list runningvms
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