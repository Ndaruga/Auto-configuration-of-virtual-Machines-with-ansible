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
echo here

pause