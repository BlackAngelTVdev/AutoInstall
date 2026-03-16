@echo off
setlocal enabledelayedexpansion

set "DestDir=H:\Scripts"
set "LauncherPS1=%DestDir%\launcher.ps1"

REM Créer le dossier s'il n'existe pas
if not exist "%DestDir%" mkdir "%DestDir%"

REM Copier le launcher depuis le dossier source
copy /Y "%~dp0launcher.ps1" "%LauncherPS1%"

REM Lancer le PowerShell launcher
powershell -NoProfile -ExecutionPolicy Bypass -File "%LauncherPS1%"
