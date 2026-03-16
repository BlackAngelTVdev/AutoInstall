# --- Installation DBeaver (Database Manager) ---

$Host.UI.RawUI.WindowTitle = "🗄️ Installation DBeaver"

function Install-DBeaver {
    $DBeaverPath = "$env:ProgramFiles\DBeaver\dbeaver.exe"
    
    if (-not (Test-Path $DBeaverPath)) {
        Write-Host "`n> Installation DBeaver..." -ForegroundColor Cyan
        
        $DBeaverUrl = "https://dbeaver.io/files/dbeaver-ce-latest-x86_64-setup.exe"
        $DBeaverInstaller = "$env:TEMP\dbeaver_setup.exe"
        
        Invoke-WebRequest $DBeaverUrl -OutFile $DBeaverInstaller
        Start-Process $DBeaverInstaller -ArgumentList "/S" -Wait
        Remove-Item $DBeaverInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "DBeaver installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "DBeaver est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-DBeaver
