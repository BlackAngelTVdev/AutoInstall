# --- Installation WireShark (Network Analysis) ---

$Host.UI.RawUI.WindowTitle = "🔍 Installation WireShark"

function Install-Wireshark {
    $WiresharkPath = "$env:ProgramFiles\Wireshark\wireshark.exe"
    
    if (-not (Test-Path $WiresharkPath)) {
        Write-Host "`n> Installation WireShark..." -ForegroundColor Cyan
        
        $WiresharkUrl = "https://www.wireshark.org/download/win64/Wireshark-win64-latest.exe"
        $WiresharkInstaller = "$env:TEMP\wireshark_setup.exe"
        
        Invoke-WebRequest $WiresharkUrl -OutFile $WiresharkInstaller
        Start-Process $WiresharkInstaller -ArgumentList "/S /desktopicon=no" -Wait
        Remove-Item $WiresharkInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "WireShark installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "WireShark est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Wireshark
