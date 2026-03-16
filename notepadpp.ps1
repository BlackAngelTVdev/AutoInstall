# --- Installation Notepad++ ---

function Install-Notepadpp {
    $NotepadppPath = "$env:ProgramFiles\Notepad++\notepad++.exe"
    
    if (-not (Test-Path $NotepadppPath)) {
        Write-Host "`n> Installation Notepad++..." -ForegroundColor Cyan
        
        $NotepadppUrl = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.5.8/npp.8.5.8.Installer.x64.exe"
        $NotepadppInstaller = "$env:TEMP\notepadpp_setup.exe"
        
        Invoke-WebRequest $NotepadppUrl -OutFile $NotepadppInstaller
        Start-Process $NotepadppInstaller -ArgumentList "/S" -Wait
        Remove-Item $NotepadppInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Notepad++ installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Notepad++ est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Notepadpp
