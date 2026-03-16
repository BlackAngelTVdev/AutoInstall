# --- Installation Node.js ---

function Install-NodeJS {
    $NodePath = "$env:ProgramFiles\nodejs\node.exe"
    
    if (-not (Test-Path $NodePath)) {
        Write-Host "`n> Installation Node.js..." -ForegroundColor Cyan
        
        $NodeUrl = "https://nodejs.org/dist/v20.10.0/node-v20.10.0-x64.msi"
        $NodeInstaller = "$env:TEMP\nodejs_setup.msi"
        
        Invoke-WebRequest $NodeUrl -OutFile $NodeInstaller
        Start-Process msiexec.exe -ArgumentList "/i $NodeInstaller /quiet /norestart" -Wait
        Remove-Item $NodeInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Node.js installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Node.js est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-NodeJS
