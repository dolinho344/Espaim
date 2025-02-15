@echo off
title Cleaner Valorant - By ChatGPT
color 0A
echo.
echo ======================================
echo   DISCORD.GG/ZENITYCOMMUNITY
echo ======================================
echo.
echo Fechando processos do Valorant...
taskkill /F /IM VALORANT-Win64-Shipping.exe >nul 2>&1
taskkill /F /IM RiotClientServices.exe >nul 2>&1
taskkill /F /IM vgtray.exe >nul 2>&1
taskkill /F /IM Vanguard.exe >nul 2>&1

echo.
echo Limpando cache do Riot Client...
del /S /Q "%ProgramData%\Riot Games\RiotClientInstalls.json" >nul 2>&1
del /S /Q "%ProgramData%\Riot Games\Metadata" >nul 2>&1

echo.
echo Limpando arquivos temporários...
rd /S /Q "%localappdata%\Riot Games" >nul 2>&1
rd /S /Q "%localappdata%\VALORANT" >nul 2>&1
rd /S /Q "%appdata%\VALORANT" >nul 2>&1

echo.
echo Limpando logs do Vanguard...
rd /S /Q "C:\Program Files\Riot Vanguard\logs" >nul 2>&1
del /S /Q "C:\Program Files\Riot Vanguard\*.log" >nul 2>&1

echo.
echo Limpando arquivos temporários do Windows...
del /S /Q "%temp%\*" >nul 2>&1
del /S /Q "C:\Windows\Temp\*" >nul 2>&1

echo.
echo Reiniciando o Vanguard...
sc stop vgc >nul 2>&1
sc start vgc >nul 2>&1

echo.
echo ======================================
echo   LIMPEZA CONCLUÍDA COM SUCESSO!
echo ======================================
echo.
pause
exit
