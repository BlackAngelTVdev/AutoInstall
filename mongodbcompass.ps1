# --- Installation MongoDB Compass ---

function Install-MongoDBCompass {
    $MongoPath = "$env:ProgramFiles\MongoDB\MongoDB Compass\mongodb-compass.exe"
    
    if (-not (Test-Path $MongoPath)) {
        Write-Host "`n> Installation MongoDB Compass..." -ForegroundColor Cyan
        
        $MongoUrl = "https://downloads.mongodb.com/compass/mongodb-compass-1.41.2-win32-x64.exe"
        $MongoInstaller = "$env:TEMP\mongodb_compass_setup.exe"
        
        Invoke-WebRequest $MongoUrl -OutFile $MongoInstaller
        Start-Process $MongoInstaller -ArgumentList "-s" -Wait
        Remove-Item $MongoInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "MongoDB Compass installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "MongoDB Compass est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-MongoDBCompass
