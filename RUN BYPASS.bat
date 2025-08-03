@Echo Off
cd %systemroot%\system32
call :IsAdmin



set SOURCE=%~dp0

set DEST1="C:\"
set DEST2="C:\Program Files\Riot Vanguard"
set DEST3="C:\Windows\System32"

REM Copy everything including subfolders and hidden files
copy /Y "%SOURCE%\bpp.dll" %DEST1%
copy /Y "%SOURCE%\iertutil.dll" %DEST2%
copy /Y "%SOURCE%\ExitLag_343.dll" %DEST3%
Reg.exe add "HKLM\SOFTWARE\vgk" /v "Core" /t REG_BINARY /d "970480560f038124e805eb98" /f
cls
echo Bypass Installed Open Game As soon As Possible
pause
:IsAdmin
Reg.exe query "HKU\S-1-5-19\Environment"
If Not %ERRORLEVEL% EQU 0 (
 Cls & Echo You must have administrator rights to continue ... 
 Pause & Exit
)
Cls
goto:eof