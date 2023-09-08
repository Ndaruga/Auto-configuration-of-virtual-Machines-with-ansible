@echo off
cd /d "C:\Program Files\Oracle\VirtualBox"
setlocal enabledelayedexpansion


set username=%USERNAME%
rem Get the path to the VirtualBox VMs folder.
set vms_path=C:\Users\%username%\VirtualBox VMs\


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
if "%option%"=="2" goto HardDriveModify
if "%option%"=="3" goto InstallationMedia

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
) else if "%1"=="4" (
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

:HardDriveModify
echo.
echo Modify %vmName% Virtual Hard Disk size
set /p hddSize = Enter Hard Disk Size in GB: 
set VHDSize=%hddSize%*1024
set vdiFilePath=!vms_path!!vmName!\!vmName!.vdi
VBoxManage createmedium disk --filename %vdiFilePath% --size %VHDSize%
if errorlevel 1 (
    echo Error modifying VHD of %2.
    pause
    goto HardDriveModify
) else (
    echo VHD of %2 modified to %hddSize%GB successfully!
    pause
    goto controllers
)
VBoxManage storagectl %vmName% --name %controllerName% --add IDE --controller %controllerType%

:: attach storage to controller and instalation medium
VBoxManage storageattach %vmName% --storagectl %controllerName% --port 1 --device 0 --type dvddrive --medium %vdiFilePath%


:controllerMenu
echo.
echo Controller Menu
echo.
echo 1: SATA
echo 2: IDE
echo 3: SCSI
echo 0: Exit

set /p controllerName=Select the controller Name: 
set /p controllerType=

if "%controllerName%"=="0" goto options
call :setControllers
goto

:setControllers
if "%1"=="1" (
    set controllerName="SATA Controller"
    set controllerType=IntelAhci
) else if "%1"=="2" (
    set controllerName="IDE Controller"
    set controllerType=PIIX4
) else (
    echo Invalid Controller Name.
    pause
    goto controllerMenu
)

:InstallationMedia
echo.
set /p mediaPath=Enter the Path to your Installation Media (eg .iso): 
echo Please Note that the IDE controller is recomended.
goto controllerMenu

VBoxManage storagectl %vmName% --name %controllerName% --add IDE --controller %controllerType%

:: attach storage to controller and instalation medium
VBoxManage storageattach %vmName% --storagectl %controllerName% --port 1 --device 0 --type dvddrive --medium %mediaPath%

:end
exit /b
