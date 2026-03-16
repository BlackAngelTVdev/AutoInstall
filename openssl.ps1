# --- Installation OpenSSL ---

$Host.UI.RawUI.WindowTitle = "🔐 Installation OpenSSL"

function Install-OpenSSL {
    $OpenSSLPath = "$env:ProgramFiles\OpenSSL-Win64\bin\openssl.exe"
    
    if (-not (Test-Path $OpenSSLPath)) {
        Write-Host "`n> Installation OpenSSL..." -ForegroundColor Cyan
        
        $OpenSSLUrl = "https://slproweb.com/download/Win64OpenSSL-3_2_0.exe"
        $OpenSSLInstaller = "$env:TEMP\openssl_setup.exe"
        
        Invoke-WebRequest $OpenSSLUrl -OutFile $OpenSSLInstaller
        Start-Process $OpenSSLInstaller -ArgumentList "/silent /verysilent /sp-" -Wait
        Remove-Item $OpenSSLInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "OpenSSL installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "OpenSSL est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-OpenSSL
