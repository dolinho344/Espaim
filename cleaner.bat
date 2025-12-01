@echo off
chcp 65001 >nul
title NEURO CLEANER
color 0E

cls
echo.
echo ███╗   ██╗███████╗██╗   ██╗██████╗  ██████╗ 
echo ████╗  ██║██╔════╝██║   ██║██╔══██╗██╔═══██╗
echo ██╔██╗ ██║█████╗  ██║   ██║██████╔╝██║   ██║
echo ██║╚██╗██║██╔══╝  ██║   ██║██╔══██╗██║   ██║
echo ██║ ╚████║███████╗╚██████╔╝██║  ██║╚██████╔╝
echo ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝ 
echo.
echo      NEURO CLEANER FOR CG
echo ═════════════════════════════════════════════════════
echo.
timeout /t 1 /nobreak >nul

net session >nul 2>&1
if %errorLevel% neq 0 (
    color 0C
    cls
    echo.
    echo ERROR: Administrator privileges required
    echo Right-click and select "Run as administrator"
    echo.
    timeout /t 5
    exit
)

cls
echo.
echo Starting cleanup process...
echo.
timeout /t 1 /nobreak >nul

echo [*] Terminating processes...
taskkill /F /IM "Riot Vanguard.exe" /T >nul 2>&1
taskkill /F /IM "vgtray.exe" /T >nul 2>&1
taskkill /F /IM "vgc.exe" /T >nul 2>&1
taskkill /F /IM "RiotClientServices.exe" /T >nul 2>&1
taskkill /F /IM "RiotClientUx.exe" /T >nul 2>&1
taskkill /F /IM "RiotClientCrashHandler.exe" /T >nul 2>&1
taskkill /F /IM "RiotClient.exe" /T >nul 2>&1
taskkill /F /IM "VALORANT.exe" /T >nul 2>&1
taskkill /F /IM "VALORANT-Win64-Shipping.exe" /T >nul 2>&1
taskkill /F /IM "LeagueClient.exe" /T >nul 2>&1
taskkill /F /IM "LeagueClientUx.exe" /T >nul 2>&1
taskkill /F /IM "LeagueClientUxRender.exe" /T >nul 2>&1
taskkill /F /IM "LeagueCrashHandler.exe" /T >nul 2>&1
taskkill /F /IM "League of Legends.exe" /T >nul 2>&1
taskkill /F /IM "LoR.exe" /T >nul 2>&1
timeout /t 2 /nobreak >nul

echo [*] Stopping services...
sc stop vgc >nul 2>&1
sc stop vgk >nul 2>&1
timeout /t 1 /nobreak >nul
sc delete vgc >nul 2>&1
sc delete vgk >nul 2>&1
net stop vgc >nul 2>&1
net stop vgk >nul 2>&1

echo [*] Removing drivers...
if exist "%SystemRoot%\System32\drivers\vgk.sys" (
    takeown /f "%SystemRoot%\System32\drivers\vgk.sys" >nul 2>&1
    icacls "%SystemRoot%\System32\drivers\vgk.sys" /grant administrators:F >nul 2>&1
    del /f /q "%SystemRoot%\System32\drivers\vgk.sys" >nul 2>&1
)
if exist "%SystemRoot%\System32\drivers\vgc.sys" (
    takeown /f "%SystemRoot%\System32\drivers\vgc.sys" >nul 2>&1
    icacls "%SystemRoot%\System32\drivers\vgc.sys" /grant administrators:F >nul 2>&1
    del /f /q "%SystemRoot%\System32\drivers\vgc.sys" >nul 2>&1
)

echo [*] Cleaning directories...
if exist "C:\Program Files\Riot Games" (
    takeown /f "C:\Program Files\Riot Games" /r /d y >nul 2>&1
    icacls "C:\Program Files\Riot Games" /grant administrators:F /t >nul 2>&1
    rd /s /q "C:\Program Files\Riot Games" >nul 2>&1
)
if exist "C:\Program Files (x86)\Riot Games" (
    takeown /f "C:\Program Files (x86)\Riot Games" /r /d y >nul 2>&1
    icacls "C:\Program Files (x86)\Riot Games" /grant administrators:F /t >nul 2>&1
    rd /s /q "C:\Program Files (x86)\Riot Games" >nul 2>&1
)
if exist "C:\Riot Games" (
    takeown /f "C:\Riot Games" /r /d y >nul 2>&1
    icacls "C:\Riot Games" /grant administrators:F /t >nul 2>&1
    rd /s /q "C:\Riot Games" >nul 2>&1
)

echo [*] Cleaning user data...
if exist "%LOCALAPPDATA%\Riot Games" rd /s /q "%LOCALAPPDATA%\Riot Games" >nul 2>&1
if exist "%APPDATA%\Riot Games" rd /s /q "%APPDATA%\Riot Games" >nul 2>&1
if exist "%PROGRAMDATA%\Riot Games" (
    takeown /f "%PROGRAMDATA%\Riot Games" /r /d y >nul 2>&1
    icacls "%PROGRAMDATA%\Riot Games" /grant administrators:F /t >nul 2>&1
    rd /s /q "%PROGRAMDATA%\Riot Games" >nul 2>&1
)
if exist "%USERPROFILE%\Riot Games" rd /s /q "%USERPROFILE%\Riot Games" >nul 2>&1

echo [*] Cleaning cache...
if exist "%TEMP%\Riot Games" rd /s /q "%TEMP%\Riot Games" >nul 2>&1
if exist "%TMP%\Riot Games" rd /s /q "%TMP%\Riot Games" >nul 2>&1
if exist "%LOCALAPPDATA%\Temp\Riot Games" rd /s /q "%LOCALAPPDATA%\Temp\Riot Games" >nul 2>&1
del /f /s /q "%TEMP%\Riot*.tmp" >nul 2>&1
del /f /s /q "%TEMP%\vanguard*.tmp" >nul 2>&1
del /f /s /q "%TEMP%\VALORANT*.tmp" >nul 2>&1
del /f /s /q "%TEMP%\League*.tmp" >nul 2>&1

echo [*] Cleaning logs...
if exist "%LOCALAPPDATA%\VALORANT\Saved\Logs" rd /s /q "%LOCALAPPDATA%\VALORANT\Saved\Logs" >nul 2>&1
if exist "%PROGRAMDATA%\Riot Games\Metadata" rd /s /q "%PROGRAMDATA%\Riot Games\Metadata" >nul 2>&1

echo [*] Cleaning crash dumps...
if exist "%LOCALAPPDATA%\CrashDumps" (
    del /f /q "%LOCALAPPDATA%\CrashDumps\Riot*.dmp" >nul 2>&1
    del /f /q "%LOCALAPPDATA%\CrashDumps\VALORANT*.dmp" >nul 2>&1
    del /f /q "%LOCALAPPDATA%\CrashDumps\League*.dmp" >nul 2>&1
)

echo [*] Cleaning registry...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Riot Games" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Riot Games" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgc" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\vgk" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vgc" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\vgk" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Riot Game valorant.live" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Riot Game league_of_legends.live" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Riot Games" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\riotgames" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\riotgames" /f >nul 2>&1
reg delete "HKEY_CLASSES_ROOT\riot" /f >nul 2>&1

for /f "tokens=*" %%a in ('reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Riot" 2^>nul ^| findstr "HKEY"') do reg delete "%%a" /f >nul 2>&1
for /f "tokens=*" %%a in ('reg query "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" /s /f "Riot" 2^>nul ^| findstr "HKEY"') do reg delete "%%a" /f >nul 2>&1

echo [*] Cleaning shortcuts...
if exist "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Riot Games" rd /s /q "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Riot Games" >nul 2>&1
if exist "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Riot Games" rd /s /q "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Riot Games" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\Valorant.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\VALORANT.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\Riot Client.lnk" >nul 2>&1
del /f /q "%USERPROFILE%\Desktop\League of Legends.lnk" >nul 2>&1
del /f /q "%PUBLIC%\Desktop\Valorant.lnk" >nul 2>&1
del /f /q "%PUBLIC%\Desktop\VALORANT.lnk" >nul 2>&1
del /f /q "%PUBLIC%\Desktop\League of Legends.lnk" >nul 2>&1

echo [*] Cleaning scheduled tasks...
schtasks /delete /tn "RiotClient*" /f >nul 2>&1
schtasks /delete /tn "Riot*" /f >nul 2>&1

echo [*] Cleaning prefetch...
del /f /q "%SystemRoot%\Prefetch\RIOT*.pf" >nul 2>&1
del /f /q "%SystemRoot%\Prefetch\VALORANT*.pf" >nul 2>&1
del /f /q "%SystemRoot%\Prefetch\LEAGUE*.pf" >nul 2>&1
del /f /q "%SystemRoot%\Prefetch\VG*.pf" >nul 2>&1

echo [*] Scanning all drives...
for %%d in (D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%d:\Riot Games" (
        takeown /f "%%d:\Riot Games" /r /d y >nul 2>&1
        icacls "%%d:\Riot Games" /grant administrators:F /t >nul 2>&1
        rd /s /q "%%d:\Riot Games" >nul 2>&1
    )
)

timeout /t 1 /nobreak >nul
cls
color 0A
echo.
echo ═════════════════════════════════════════════════════
echo.
echo   Cleanup completed successfully
echo.
echo ═════════════════════════════════════════════════════
echo.
echo All files and registry entries have been removed.
echo.
echo Restart your computer to complete the process.
echo.
echo Restart now? (Y/N)
set /p restart=Choice: 

if /i "%restart%"=="Y" (
    shutdown /r /t 10 /c "System restart required"
) else (
    echo Please restart manually when ready.
)

timeout /t 3
exit