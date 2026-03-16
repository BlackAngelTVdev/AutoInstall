# --- Installation Docker ---

function Install-Docker {
    $DockerPath = "$env:ProgramFiles\Docker\Docker\Docker.exe"
    
    if (-not (Test-Path $DockerPath)) {
        Write-Host "`n> Installation Docker Desktop..." -ForegroundColor Cyan
        
        $DockerUrl = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
        $DockerInstaller = "$env:TEMP\docker_setup.exe"
        
        Invoke-WebRequest $DockerUrl -OutFile $DockerInstaller
        Start-Process $DockerInstaller -ArgumentList "install --quiet" -Wait
        Remove-Item $DockerInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Docker Desktop installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Docker est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Docker
