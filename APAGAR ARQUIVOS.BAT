@echo off
echo Este script ira apagar os seguintes arquivos:
echo - gdrv_svc.sys
echo - ieframe.sys  
echo - LocationApi.sys
echo.
echo DA Pasta: %SystemRoot%\System32\drivers
echo.


echo.
echo Apagando arquivos...

del "%SystemRoot%\System32\drivers\gdrv_svc.sys" 2>nul
if errorlevel 1 (
    echo Nao foi possivel apagar gdrv_svc.sys (arquivo pode nao existir)
) else (
    echo gdrv_svc.sys apagado com sucesso
)

del "%SystemRoot%\System32\drivers\ieframe.sys" 2>nul
if errorlevel 1 (
    echo Nao foi possivel apagar ieframe.sys (arquivo pode nao existir)
) else (
    echo ieframe.sys apagado com sucesso
)

del "%SystemRoot%\System32\drivers\LocationApi.sys" 2>nul
if errorlevel 1 (
    echo Nao foi possivel apagar LocationApi.sys (arquivo pode nao existir)
) else (
    echo LocationApi.sys apagado com sucesso
)

echo.
echo Operacao concluida.
pause