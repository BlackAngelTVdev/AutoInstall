$ErrorActionPreference = "Continue" 
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

# --- Titre de la fenêtre ---
$Host.UI.RawUI.WindowTitle = "⚙️  Menu d'Installation - AutoInstall"

# --- Fonctions ---
function Get-LatestGitHubRelease {
    param([string]$Repo)
    $url = "https://api.github.com/repos/$Repo/releases/latest"
    return Invoke-RestMethod -Uri $url -UseBasicParsing
}

# --- Affichage du Menu ---
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# Récupère tous les fichiers .ps1 (sauf Setup.ps1)
$InstallScripts = @()
$ScriptFiles = Get-ChildItem "$ScriptDir\*.ps1" -Exclude "Setup.ps1" | Sort-Object Name
foreach ($Script in $ScriptFiles) {
    $InstallScripts += @{
        Name = $Script.BaseName
        Path = $Script.FullName
    }
}

Clear-Host
Write-Host "==========================================" -ForegroundColor Magenta
Write-Host "         MENU D'INSTALLATION              " -ForegroundColor Magenta
Write-Host "==========================================" -ForegroundColor Magenta
Write-Host " 0 [ ] INSTALLER TOUT" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Gray

# Affiche dynamiquement le menu
for ($i = 0; $i -lt $InstallScripts.Count; $i++) {
    $Number = $i + 1
    $ScriptName = $InstallScripts[$i].Name
    Write-Host " $Number [ ] $ScriptName"
}

Write-Host "=========================================="
$Selection = Read-Host "Choix (ex: 1,2,3 ou 0 pour tout)"
$SelectedIDs = $Selection.Split(",").Trim()

# Si l'utilisateur tape 0, installer tous les scripts
if ($SelectedIDs -contains "0") {
    $SelectedIDs = @()
    for ($i = 1; $i -le $InstallScripts.Count; $i++) {
        $SelectedIDs += [string]$i
    }
}

try {
    # Exécute les scripts sélectionnés
    foreach ($ID in $SelectedIDs) {
        $Index = [int]$ID - 1
        
        if ($Index -ge 0 -and $Index -lt $InstallScripts.Count) {
            $ScriptPath = $InstallScripts[$Index].Path
            Write-Host "`n>>> Exécution de $($InstallScripts[$Index].Name)..." -ForegroundColor Yellow
            & $ScriptPath
            
            # Firefox nécessite un redémarrage d'Explorer
            if ($InstallScripts[$Index].Name -eq "firefox") {
                $NeedsRestart = $true
            }
        } else {
            Write-Host "`n[AVERTISSEMENT] Choix invalide : $ID" -ForegroundColor Yellow
        }
    }

} catch {
    Write-Host "`n[ERREUR] : $($_.Exception.Message)" -ForegroundColor Red
}

if ($NeedsRestart) {
    Write-Host "`nRafraîchissement de l'explorateur..." -ForegroundColor Yellow
    Stop-Process -Name explorer -Force -ErrorAction SilentlyContinue
}

Write-Host "`n--- Script terminé ---" -ForegroundColor Magenta
Write-Host "Appuie sur Entrée pour fermer..."
Read-Host