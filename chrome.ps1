# --- Installation Chrome ---

function Install-Chrome {
    $ChromePath = "$env:ProgramFiles\Google\Chrome\Application\chrome.exe"
    
    if (-not (Test-Path $ChromePath)) {
        Write-Host "`n> Installation Chrome..." -ForegroundColor Cyan
        $ChromeUrl = "https://dl.google.com/chrome/install/googlechromestandaloneenterprise64.msi"
        $ChromeInstaller = "$env:TEMP\chrome_setup.msi"
        Invoke-WebRequest $ChromeUrl -OutFile $ChromeInstaller
        Start-Process msiexec.exe -ArgumentList "/i $ChromeInstaller /quiet /norestart" -Wait
        Remove-Item $ChromeInstaller -Force -ErrorAction SilentlyContinue
    }
    
    # Nettoyage Taskbar des raccourcis Edge
    $TaskbarPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
    Get-ChildItem "$TaskbarPath" -Filter "*Edge*" | Remove-Item -Force -ErrorAction SilentlyContinue
    
    try {
        $Shell = New-Object -ComObject Shell.Application
        $Folder = $Shell.NameSpace((Split-Path $ChromePath))
        $File = $Folder.ParseName((Split-Path $ChromePath -Leaf))
        $Verb = $File.Verbs() | Where-Object { $_.Name.Replace("&", "") -match "Épingler à la barre des tâches|Pin to taskbar" }
        if ($Verb) { $Verb.DoIt() }
    } catch { Write-Host "L'épinglage a échoué, fais-le manuellement." -ForegroundColor Yellow }
    
    # Définir Chrome comme navigateur par défaut
    Write-Host "Configuration de Chrome comme navigateur par défaut..." -ForegroundColor Yellow
    try {
        $ChromeExe = "C:\Program Files\Google\Chrome\Application\chrome.exe"
        if (Test-Path $ChromeExe) {
            # Utiliser ChromeHTML pour .html
            cmd /c "assoc .html=ChromeHTML 2>nul"
            cmd /c "ftype ChromeHTML=`"$ChromeExe`" %%1 2>nul"
            
            # Utiliser Chrome pour http et https
            cmd /c "assoc .htm=ChromeHTML 2>nul"
            cmd /c "assoc .url=ChromeHTML 2>nul"
            
            Write-Host "Configuration effectuée!" -ForegroundColor Green
            Write-Host "Important: Va dans Paramètres > Applications > Applis par défaut" -ForegroundColor Yellow
            Write-Host "et définis Chrome comme navigateur web pour terminer." -ForegroundColor Yellow
        }
    } catch {
        Write-Host "Erreur lors de la configuration : $_" -ForegroundColor Red
    }
    
    return $true
}

Install-Chrome
