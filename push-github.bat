@echo off
REM --- Script pour pusher le projet sur GitHub ---

echo.
echo ======================================================
echo         PUSH VERS GITHUB
echo ======================================================
echo.

set /p RepoURL="Colle l'URL du repo GitHub (ex: https://github.com/BlackAngelTVDev/auto-installer.git): "

echo.
echo [1/3] Ajout des fichiers...
git add .

echo [2/3] Commit...
git commit -m "Initial commit: Auto-installer avec VSCodium, extensions et 15+ logiciels"

echo [3/3] Push vers GitHub...
git push -u origin main

echo.
echo ======================================================
echo PUSH TERMINE !
echo ======================================================
pause
