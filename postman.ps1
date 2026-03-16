# --- Installation Postman ---

function Install-Postman {
    $PostmanPath = "$env:LOCALAPPDATA\Postman\Postman.exe"
    
    if (-not (Test-Path $PostmanPath)) {
        Write-Host "`n> Installation Postman..." -ForegroundColor Cyan
        
        $PostmanUrl = "https://dl.pstmn.io/download/latest/win64"
        $PostmanInstaller = "$env:TEMP\postman_setup.exe"
        
        Invoke-WebRequest $PostmanUrl -OutFile $PostmanInstaller
        Start-Process $PostmanInstaller -ArgumentList "-s" -Wait
        Remove-Item $PostmanInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Postman installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Postman est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Postman
