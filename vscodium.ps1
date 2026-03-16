# --- Installation VSCodium ---

$Host.UI.RawUI.WindowTitle = "💻 Installation VSCodium"

function Get-LatestGitHubRelease {
    param([string]$Repo)
    $url = "https://api.github.com/repos/$Repo/releases/latest"
    return Invoke-RestMethod -Uri $url -UseBasicParsing
}

function Install-VSCodium {
    Write-Host "`n> Installation VSCodium..." -ForegroundColor Cyan
    
    $Release = Get-LatestGitHubRelease "VSCodium/vscodium"
    $Asset = $Release.assets | Where-Object { $_.name -like "VSCodiumUserSetup-x64-*.exe" } | Select-Object -First 1
    
    if ($Asset) {
        $CodiumInstaller = "$env:TEMP\vscodium_setup.exe"
        Invoke-WebRequest -Uri $Asset.browser_download_url -OutFile $CodiumInstaller
        Start-Process $CodiumInstaller -ArgumentList '/VERYSILENT','/MERGETASKS=!runcode,addcontextmenufiles,addcontextmenufolders' -Wait
    }
    
    Write-Host "VSCodium installé !" -ForegroundColor Green
    
    # Attendre que VSCodium se configure
    Start-Sleep -Seconds 5
    
    # Installation des extensions dans une nouvelle fenêtre PowerShell
    Write-Host "`n> Lancement de l'installation des extensions dans une nouvelle fenêtre..." -ForegroundColor Yellow
    
    $ExtensionsScript = @"
`$Host.UI.RawUI.WindowTitle = "📦 Installation des Extensions VSCodium"

Write-Host "Installation des extensions VSCodium..." -ForegroundColor Cyan

`$Extensions = @(
    "adrianwilker.vscode-adonisjs",
    "bradlc.vscode-tailwindcss",
    "octref.vetur",
    "vue.volar",
    "zhuenzhuo.edge-template-syntax",
    "zhuenzhuo.edge-html-snippets",
    "ms-vscode-remote.remote-wsl",
    "ms-vscode.remote-explorer",
    "dracula-theme.theme-dracula",
    "zhuenzhuo.one-dark-pro"
)

foreach (`$Extension in `$Extensions) {
    Write-Host "  > Installation de `$Extension..." -ForegroundColor Yellow
    & "codium" --install-extension `$Extension --force 2>null
}

Write-Host "Extensions installées avec succès!" -ForegroundColor Green
Write-Host "Appuie sur Entrée pour fermer..." -ForegroundColor Gray
Read-Host
"@
    
    # Créer un script temporaire pour les extensions
    $TempScript = "$env:TEMP\install_extensions.ps1"
    Set-Content -Path $TempScript -Value $ExtensionsScript
    
    # Lancer dans une NOUVELLE fenêtre PowerShell séparée
    Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$TempScript`"" -Wait
    
    # Nettoyer le script temporaire
    Remove-Item $TempScript -Force -ErrorAction SilentlyContinue
    
    Write-Host "Installation des extensions terminée !" -ForegroundColor Green
}

Install-VSCodium
