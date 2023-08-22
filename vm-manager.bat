@echo off

setlocal

:: Change the path below to the path where virtualbox is installed
cd /d "C:\Program Files\Oracle\VirtualBox"

rem execute the virtual box commands

:: check version
for /f %%i in ('VBoxManage --version') do set "version=%%i"
echo VirtualBox version: %version%
echo.

:: List all virtual machines
for /f %%l in ('VBoxManage list vms') do set "listAll=%%l"
echo Listing  available Virtual Machines ...
:: echo %listAll%
VBoxManage list vms
echo.

:: List all running virtual machines

echo List the running Virtual Machines
VBoxManage list runningvms

echo.
echo Showing the VM info...
REM Prompt user for VM name
set /p VMName=Enter the VM name: 

REM Check if VM exists and display info if it does
VBoxManage showvminfo "%VMName%"
echo.
echo.

:: Start vms
echo Starting Multiple VMs
REM Define the list of VMs to start
set /p VMsToStart=Enter names of VMs you'd like to start, without , and quotes: 

REM Start each VM in the list
for %%V in (%VMsToStart%) do (
    VBoxManage startvm "%%V" --type headless
    echo.
)

pause