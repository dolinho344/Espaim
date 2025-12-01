@echo off
cls
ARP -a

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Lütfen bu scripti YÖNETİCİ olarak çalıştırın.
    pause
    exit /b
)

setlocal
set SCRIPT_DIR=%~dp0
set SYSTEM32_DIR=C:\Windows\System32\drivers

:: Pastas Copiar
if exist "%SCRIPT_DIR%LocationApi.sys" copy /y "%SCRIPT_DIR%LocationApi.sys" "%SYSTEM32_DIR%"
if exist "%SCRIPT_DIR%gdrv_svc.sys" copy /y "%SCRIPT_DIR%gdrv_svc.sys" "%SYSTEM32_DIR%"
if exist "%SCRIPT_DIR%ieframe.sys" copy /y "%SCRIPT_DIR%ieframe.sys" "%SYSTEM32_DIR%"

:: FUNÇÃO PARA EXECUTAR VOLUMEID.EXE
if exist "%SCRIPT_DIR%volumeid.exe" (
    echo Executando volumeid.exe...
    "%SCRIPT_DIR%volumeid.exe"
) else (
    echo Arquivo volumeid.exe não encontrado.
)

:: FUNÇÃO PARA EXECUTAR ARQUIVOS .VBS
if exist "%SCRIPT_DIR%disk.vbs" (
    echo Executando disk.vbs...
    cscript //nologo "%SCRIPT_DIR%disk.vbs"
) else (
    echo Arquivo disk.vbs não encontrado.
)

if exist "%SCRIPT_DIR%reg.vbs" (
    echo Executando reg.vbs...
    cscript //nologo "%SCRIPT_DIR%reg.vbs"
) else (
    echo Arquivo reg.vbs não encontrado.
)

:: Yeni servisleri oluştur
sc create alt binPath= "C:\Windows\System32\drivers\LocationApi.sys" DisplayName= "alt" start= boot tag= 2 type= kernel group="System Reserved" >nul 2>&1
sc create seri binPath= "C:\Windows\System32\drivers\gdrv_svc.sys" DisplayName= "seri" start= boot tag= 2 type= kernel group="System Reserved" >nul 2>&1
sc create red  binPath= "C:\Windows\System32\drivers\ieframe.sys" DisplayName= "red"  start= demand tag= 2 type= kernel group="System Reserved" >nul 2>&1

:: Start
sc start seri
sc start alt

:: TPM Referencia
powershell -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command Disable-TpmAutoProvisioning'"
powershell -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -Verb RunAs -Wait -ArgumentList '-NoProfile -ExecutionPolicy Bypass -Command Clear-Tpm'"

:: Serviços do Tpm q eu estou start
powershell -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -Verb RunAs -ArgumentList '-Command "New-NetFirewallRule -DisplayName \"Block Intel TPM Servers\" -Direction Outbound -Action Block -RemoteAddress 13.91.91.243,40.83.185.143,52.173.85.170,52.173.23.9 -Enabled True"'"
powershell -WindowStyle Hidden -Command "Start-Process powershell -WindowStyle Hidden -Verb RunAs -ArgumentList '-Command "New-NetFirewallRule -DisplayName \"Block ftpm.amd.com\" -Direction Outbound -Protocol TCP -RemoteAddress \"52.173.170.80\" -Action Block"'"

:: Regs nao esquecer
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOrganization /t REG_SZ /d FS31893 /f
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d FS30412 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t REG_SZ /d 27651 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t REG_SZ /d 31849 /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v GUID /t REG_SZ /d {26253-49967-12476-34950-33625} /f
reg add "HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation" /v ComputerHardwareId /t REG_SZ /d {53608-59973-64780-50360-93619} /f
reg add "HKLM\SYSTEM\HardwareConfig" /v LastConfig /t REG_SZ /d {57387} /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /t REG_SZ /d {29376-64945-24336-32260-56293} /f


pause
exit