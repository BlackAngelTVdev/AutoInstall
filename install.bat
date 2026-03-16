@echo off
set "DestDir=H:\Scripts"
set "LauncherName=%DestDir%\RunInstall.bat"
set "StartupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

echo [1/2] Creation du dossier sur H:...
if not exist "%DestDir%" mkdir "%DestDir%"

echo [2/2] Creation du raccourci dans ton profil (Startup)...
set "ShortcutScript=%TEMP%\CreateShortcut.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%ShortcutScript%"
echo sLinkFile = "%StartupFolder%\AutoSetup.lnk" >> "%ShortcutScript%"
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> "%ShortcutScript%"
echo oLink.TargetPath = "%LauncherName%" >> "%ShortcutScript%"
echo oLink.Save >> "%ShortcutScript%"
cscript /nologo "%ShortcutScript%"
del "%ShortcutScript%"

echo.
echo ======================================================
echo CONFIGURATION TERMINEE !
echo.
echo Le launcher vérifiera les updates à chaque démarrage
echo et téléchargera les nouveaux fichiers depuis GitHub.
echo.
echo Ou clique sur Y pour lancer maintenant...
echo ======================================================
set /p LaunchNow="Lancer le Setup maintenant ? (Y/N): "
if /i "%LaunchNow%"=="Y" (
    start powershell -ExecutionPolicy Bypass -File "%~dp0launcher.ps1"
) else (
    pause
)