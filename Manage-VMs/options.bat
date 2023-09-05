@echo off

setlocal
echo WELCOME TO CONFIGURATION OF VIRTUAL MACHINES
:: Change the path below to the path where virtualbox is installed
cd /d "C:\Program Files\Oracle\VirtualBox"

:start
:: Prompt the user to enter an option
echo.
echo.
echo What would you like to do? Please enter the option number from the available options below:
echo.
echo 2: List All Running VMs
echo 3: List all VMs
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

:: Check the option and run the corresponding command
::if "%option%" == 1(
:: check version
for /f %%i in ('VBoxManage --version') do set "version=%%i"
echo VirtualBox version: %version%
echo.
::) else if "%option%" == "2" (
VBoxManage list runningvms
::) else if "%option%" == "3" (
::    VBoxManage list vms
::) else if "%option%" == "4" (
::    VBoxManage modifyvm <VM name> --nested-hw-virt on
::) else if "%option%" == "5" (
::    VBoxManage showvminfo <VM name>
::) else if "%option%" == "6" (
::    VBoxManage modifyvm <VM name> --memory <amount of RAM>
::) else if "%option%" == "7" (
::    VBoxManage modifyvm <VM name> --cpus <number of CPUs>
::) else if "%option%" == "8" (
::    VBoxManage startvm <VM name>
::) else if "%option%" == "9" (
::    VBoxManage poweroff <VM name>
::) else if "%option%" == "10" (
::    VBoxManage pausevm <VM name>
::) else if "%option%" == "11" (
::    VBoxManage resumevm <VM name>
::) else if "%option%" == "12" (
::    VBoxManage savestate <VM name>
::) else if "%option%" == "13" (
::    VBoxManage resetvm <VM name>
::) else if "%option%" == "14" (
::    VBoxManage list ostypes
::) else (
::    echo Invalid option
::)

@REM Prompt the user to exit or continue
echo.
echo Do you want to exit? (y/n)
set /p choice=

if "%choice%" == "y" (
    exit
) else (
    goto start
)

pause