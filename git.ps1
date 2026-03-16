# --- Installation Git ---

function Install-Git {
    $GitPath = "$env:ProgramFiles\Git\bin\git.exe"
    
    if (-not (Test-Path $GitPath)) {
        Write-Host "`n> Installation Git..." -ForegroundColor Cyan
        
        $GitUrl = "https://github.com/git-for-windows/git/releases/download/v2.43.0.windows.1/Git-2.43.0-64-bit.exe"
        $GitInstaller = "$env:TEMP\git_setup.exe"
        
        Invoke-WebRequest $GitUrl -OutFile $GitInstaller
        Start-Process $GitInstaller -ArgumentList "/VERYSILENT /NORESTART" -Wait
        Remove-Item $GitInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Git installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Git est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Git
