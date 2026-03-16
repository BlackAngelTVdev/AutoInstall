# --- Installation Insomnia (API Client) ---

function Install-Insomnia {
    $InsomniaPath = "$env:LOCALAPPDATA\Insomnia\Insomnia.exe"
    
    if (-not (Test-Path $InsomniaPath)) {
        Write-Host "`n> Installation Insomnia..." -ForegroundColor Cyan
        
        $InsomniaUrl = "https://updates.insomnia.rest/downloads/windows/latest"
        $InsomniaInstaller = "$env:TEMP\insomnia_setup.exe"
        
        Invoke-WebRequest $InsomniaUrl -OutFile $InsomniaInstaller
        Start-Process $InsomniaInstaller -ArgumentList "--silent" -Wait
        Remove-Item $InsomniaInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Insomnia installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Insomnia est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Insomnia
