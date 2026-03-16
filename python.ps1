# --- Installation Python ---

function Install-Python {
    $PythonPath = "$env:ProgramFiles\Python312\python.exe"
    
    if (-not (Test-Path $PythonPath)) {
        Write-Host "`n> Installation Python..." -ForegroundColor Cyan
        
        $PythonUrl = "https://www.python.org/ftp/python/3.12.0/python-3.12.0-amd64.exe"
        $PythonInstaller = "$env:TEMP\python_setup.exe"
        
        Invoke-WebRequest $PythonUrl -OutFile $PythonInstaller
        Start-Process $PythonInstaller -ArgumentList "/quiet InstallAllUsers=1 PrependPath=1" -Wait
        Remove-Item $PythonInstaller -Force -ErrorAction SilentlyContinue
        
        Write-Host "Python installé avec succès!" -ForegroundColor Green
    } else {
        Write-Host "Python est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-Python
