# Verificar se está executando como Administrator
if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    echo "Reexecutando como Administrador..."
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# AGORA EXECUTANDO COMO ADMINISTRATOR
Write-Host "=== Bloqueando servidores TPM (mantendo TPM ativo) ===" -ForegroundColor Green

# 1. GARANTIR que o TPM está ATIVO e funcionando
try {
    Write-Host "Ativando TPM..." -ForegroundColor Yellow
    Enable-TpmAutoProvisioning
    Start-Service Tpm -ErrorAction SilentlyContinue
    Set-Service Tpm -StartupType Automatic
    Write-Host "TPM ativado e funcionando" -ForegroundColor Green
} catch {
    Write-Host "Aviso: Não foi possível ativar TPM: $_" -ForegroundColor Yellow
}

# 2. Bloquear APENAS os servidores remotos TPM
Write-Host "Bloqueando servidores TPM externos..." -ForegroundColor Yellow
$TPM_IPs = @(
    "13.91.91.243",    # Servidores TPM Microsoft
    "40.83.185.143",   # Servidores TPM Microsoft  
    "52.173.85.170",   # Servidores TPM Microsoft
    "52.173.23.9",     # Servidores TPM Microsoft
    "52.173.170.80",   # ftpm.amd.com
    "20.42.65.116",    # Servidores TPM adicionais
    "20.112.250.133",  # Servidores TPM adicionais
    "40.76.4.15"       # Servidores TPM adicionais
)

foreach ($ip in $TPM_IPs) {
    try {
        $ruleName = "Block TPM Server $ip"
        # Remove regra existente se houver
        Remove-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
        # Cria nova regra de BLOQUEIO
        New-NetFirewallRule -DisplayName $ruleName -Direction Outbound -Action Block -RemoteAddress $ip -Enabled True
        Write-Host "Servidor TPM $ip bloqueado" -ForegroundColor Green
    } catch {
        Write-Host "Erro ao bloquear $ip : $_" -ForegroundColor Red
    }
}

# 3. Verificar status do TPM
Write-Host "`nVerificando status do TPM..." -ForegroundColor Cyan
try {
    $tpmStatus = Get-Tpm
    if ($tpmStatus.TpmPresent -and $tpmStatus.TpmReady) {
        Write-Host "✓ TPM está PRESENTE e PRONTO" -ForegroundColor Green
        Write-Host "✓ TPM.msc vai mostrar funcionando normalmente" -ForegroundColor Green
    } else {
        Write-Host "! TPM não está pronto. Status: $($tpmStatus.TpmStatus)" -ForegroundColor Yellow
    }
} catch {
    Write-Host "! Não foi possível verificar status TPM" -ForegroundColor Red
}

Write-Host "`n=== PROCESSO CONCLUÍDO ===" -ForegroundColor Cyan
Write-Host "TPM mantido ATIVO + Servidores bloqueados" -ForegroundColor Green
Write-Host "Reinicie o PC e teste:" -ForegroundColor Yellow
Write-Host "1. Execute 'tpm.msc' - deve mostrar TPM funcionando" -ForegroundColor White
Write-Host "2. Teste o Valorant" -ForegroundColor White
pause