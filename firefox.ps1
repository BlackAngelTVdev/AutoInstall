# --- Installation Firefox ---

function Get-LatestGitHubRelease {
    param([string]$Repo)
    $url = "https://api.github.com/repos/$Repo/releases/latest"
    return Invoke-RestMethod -Uri $url -UseBasicParsing
}

function Install-Firefox {
    $FirefoxDir = "$env:LOCALAPPDATA\Programs\Firefox"
    $FirefoxExe = "$FirefoxDir\firefox.exe"
    
    if (-not (Test-Path $FirefoxExe)) {
        Write-Host "`n> Installation Firefox..." -ForegroundColor Cyan
        $FirefoxUrl = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=fr"
        $FirefoxInstaller = "$env:TEMP\firefox_setup.exe"
        Invoke-WebRequest $FirefoxUrl -OutFile $FirefoxInstaller
        Start-Process $FirefoxInstaller -ArgumentList "/S /InstallDirectoryPath=$FirefoxDir" -Wait
    }

    # Nettoyage Taskbar
    $TaskbarPath = "$env:APPDATA\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar"
    Get-ChildItem "$TaskbarPath" -Filter "*Edge*" | Remove-Item -Force -ErrorAction SilentlyContinue
    
    try {
        $Shell = New-Object -ComObject Shell.Application
        $Folder = $Shell.NameSpace((Split-Path $FirefoxExe))
        $File = $Folder.ParseName((Split-Path $FirefoxExe -Leaf))
        $Verb = $File.Verbs() | Where-Object { $_.Name.Replace("&", "") -match "Épingler à la barre des tâches|Pin to taskbar" }
        if ($Verb) { $Verb.DoIt() }
    } catch { Write-Host "L'épinglage a échoué, fais-le manuellement." -ForegroundColor Yellow }
    
    return $true
}

Install-Firefox
