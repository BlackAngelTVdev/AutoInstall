# --- Auto-Update et Launcher ---

$Host.UI.RawUI.WindowTitle = "🚀 AutoInstall - Vérification des mises à jour"

$RepoURL = "https://github.com/BlackAngelTVdev/AutoInstall.git"
$DestDir = "H:\Scripts"
$LocalRepoDir = "H:\Scripts\.repo"
$SetupFaitFile = "$env:LOCALAPPDATA\setup_fait.txt"

Write-Host "=========================================" -ForegroundColor Cyan
Write-Host "  🚀 AUTO-INSTALLER - Vérification" -ForegroundColor Cyan
Write-Host "=========================================" -ForegroundColor Cyan

# Créer le dossier repo s'il n'existe pas
if (-not (Test-Path $LocalRepoDir)) {
    Write-Host "`n> Clonage du repo GitHub..." -ForegroundColor Yellow
    git clone $RepoURL $LocalRepoDir
} else {
    Write-Host "`n> Vérification des updates..." -ForegroundColor Yellow
    
    # Aller dans le dossier repo
    cd $LocalRepoDir
    
    # Fetch les derniers commits
    git fetch origin main
    
    # Vérifier s'il y a des différences
    $LocalCommit = git rev-parse HEAD
    $RemoteCommit = git rev-parse origin/main
    
    if ($LocalCommit -ne $RemoteCommit) {
        Write-Host "  > Nouvelles mises à jour trouvées !" -ForegroundColor Green
        Write-Host "  > Pull des changements..." -ForegroundColor Yellow
        git pull origin main
        
        # Supprimer le fichier setup_fait.txt pour relancer l'install
        if (Test-Path $SetupFaitFile) {
            Remove-Item $SetupFaitFile -Force
            Write-Host "  > Installation supprimée, relance prévue !" -ForegroundColor Green
        }
    } else {
        Write-Host "  > Vous avez la dernière version" -ForegroundColor Green
    }
}

# Copier tous les fichiers .ps1 depuis le repo vers H:\Scripts
Write-Host "`n> Copie des scripts depuis le repo..." -ForegroundColor Yellow
Copy-Item "$LocalRepoDir\*.ps1" "$DestDir\" -Force -ErrorAction SilentlyContinue
Copy-Item "$LocalRepoDir\*.bat" "$DestDir\" -Force -ErrorAction SilentlyContinue

Write-Host "=========================================" -ForegroundColor Cyan

# Vérifier si setup est déjà fait
if (Test-Path $SetupFaitFile) {
    Write-Host "`nSetup déjà effectué. Rien à faire." -ForegroundColor Green
    Write-Host "Appuie sur Entrée pour quitter..."
    Read-Host
} else {
    Write-Host "`nLancement du Setup..." -ForegroundColor Yellow
    Start-Sleep -Seconds 2
    
    # Lancer Setup.ps1
    & "$DestDir\Setup.ps1"
    
    # Marquer comme fait
    echo "Fait le $(Get-Date)" > $SetupFaitFile
}
