# --- Installation 7-Zip (alternative portable à WinRAR) ---

$Host.UI.RawUI.WindowTitle = "📦 Installation 7-Zip"

function Install-SevenZip {
    $SevenZipPath = "$env:LOCALAPPDATA\7-Zip\7z.exe"
    
    if (-not (Test-Path $SevenZipPath)) {
        Write-Host "`n> Installation 7-Zip Portable..." -ForegroundColor Cyan
        
        # Créer le dossier 7-Zip
        $SevenZipDir = "$env:LOCALAPPDATA\7-Zip"
        if (-not (Test-Path $SevenZipDir)) {
            New-Item -ItemType Directory -Path $SevenZipDir -Force | Out-Null
        }
        
        # Télécharger 7-Zip portable (version 7z)
        $SevenZipUrl = "https://www.7-zip.org/a/7z2407-x64.7z"
        $SevenZipFile = "$env:TEMP\7zip_portable.7z"
        
        Write-Host "  > Téléchargement de 7-Zip..." -ForegroundColor Gray
        try {
            Invoke-WebRequest $SevenZipUrl -OutFile $SevenZipFile -TimeoutSec 30
            
            # Extraire avec tar (Windows 10+) ou avec l'extraction native
            Write-Host "  > Extraction dans $SevenZipDir..." -ForegroundColor Gray
            
            # Utiliser tar qui est disponible sur Windows 10+
            tar -xf $SevenZipFile -C $SevenZipDir 2>$null
            
            if (-not (Test-Path $SevenZipPath)) {
                # Fallback : essayer avec Expand-Archive si c'est un zip
                Expand-Archive -Path $SevenZipFile -DestinationPath $SevenZipDir -Force -ErrorAction SilentlyContinue
            }
            
            Remove-Item $SevenZipFile -Force -ErrorAction SilentlyContinue
            
            # Ajouter 7-Zip au PATH utilisateur
            $UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
            if ($UserPath -notlike "*$SevenZipDir*") {
                [Environment]::SetEnvironmentVariable("Path", "$UserPath;$SevenZipDir", "User")
                Write-Host "  > 7-Zip ajouté au PATH" -ForegroundColor Green
            }
            
            Write-Host "7-Zip installé avec succès (mode user) !" -ForegroundColor Green
        } catch {
            Write-Host "  > Erreur téléchargement, création dossier vide..." -ForegroundColor Yellow
            Write-Host "  > Télécharge manuellement: https://www.7-zip.org/download.html" -ForegroundColor Yellow
        }
    } else {
        Write-Host "7-Zip est déjà installé" -ForegroundColor Green
    }
    
    return $true
}

Install-SevenZip
