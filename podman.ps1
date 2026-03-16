# --- Installation Podman (User Mode) ---

$Host.UI.RawUI.WindowTitle = "🐳 Installation Podman"

function Get-LatestGitHubRelease {
    param([string]$Repo)
    $url = "https://api.github.com/repos/$Repo/releases/latest"
    return Invoke-RestMethod -Uri $url -UseBasicParsing
}

function Install-Podman {
    Write-Host "`n> Installation Podman (User Mode)..." -ForegroundColor Cyan
    
    $PodmanRelease = Get-LatestGitHubRelease "containers/podman"
    $PodmanAsset = $PodmanRelease.assets | Where-Object { $_.name -like "podman-*-setup.exe" } | Select-Object -First 1
    
    if ($PodmanAsset) {
        $PodmanInstaller = "$env:TEMP\podman_setup.exe"
        Invoke-WebRequest -Uri $PodmanAsset.browser_download_url -OutFile $PodmanInstaller
        Start-Process $PodmanInstaller -ArgumentList '/S', '/User' -Wait
        Write-Host "Podman installé." -ForegroundColor Green
        Write-Host "Note: Tape 'podman machine init' dans un nouveau terminal après avoir fini." -ForegroundColor Yellow
    }
}

Install-Podman
