# --- Installation VLC ---

function Install-VLC {
    $VLCPath = "$env:ProgramFiles\VideoLAN\VLC\vlc.exe"
    
    if (-not (Test-Path $VLCPath)) {
        Write-Host "`n> Installation VLC..." -ForegroundColor Cyan
        
        $VLCUrl = "https://get.videolan.org/vlc/3.0.20/win64/vlc-3.0.20-win64.exe"
        $VLCInstaller = "$env:TEMP\vlc_setup.exe"
        
        Invoke-WebRequest $VLCUrl -OutFile $VLCInstaller
        Start-Process $VLCInstaller -ArgumentList "/S" -Wait
        Remove-Item $VLCInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "VLC installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "VLC est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-VLC
