@echo off
set "SourcePS1=%~dp0Setup.ps1"
set "DestDir=H:\Scripts"
set "LauncherName=%DestDir%\RunInstall.bat"
set "StartupFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

echo [1/4] Creation du dossier sur H:...
if not exist "%DestDir%" mkdir "%DestDir%"

echo [2/4] Copie des scripts PowerShell vers %DestDir%...
for %%F in ("%~dp0*.ps1") do (
    if not "%%~nxF"=="install.bat" (
        copy /Y "%%F" "%DestDir%\%%~nxF"
    )
)

echo [3/4] Creation du lanceur automatique...
(
echo @echo off
echo if exist "%%LOCALAPPDATA%%\setup_fait.txt" exit
echo start powershell -ExecutionPolicy Bypass -File "%DestDir%\Setup.ps1"
echo echo Fait le %%date%% %%time%% ^> "%%LOCALAPPDATA%%\setup_fait.txt"
) > "%LauncherName%"

echo [4/4] Creation du raccourci dans ton profil (Startup)...
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
echo Lance manuellement : powershell -ExecutionPolicy Bypass -File "%DestDir%\Setup.ps1"
echo.
echo Ou clique sur Y pour lancer maintenant...
echo ======================================================
set /p LaunchNow="Lancer le Setup maintenant ? (Y/N): "
if /i "%LaunchNow%"=="Y" (
    start powershell -ExecutionPolicy Bypass -File "%DestDir%\Setup.ps1"
) else (
    pause
)