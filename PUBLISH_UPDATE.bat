@echo off
title Fluffy-Cs2 - Publish update
cd /d "%~dp0"
set "REPO=9crf69djm5-creator"
set "REPO_NAME=fluffy-cs2-update"

echo.
echo Fluffy-Cs2 - Publish update to GitHub
echo -------------------------------------

powershell -NoProfile -Command ^
  "$v = (Get-Content version.txt -Raw).Trim(); $p = [version]$v; $new = '' + $p.Major + '.' + $p.Minor + '.' + ($p.Build + 1); Set-Content version.txt -Value $new -NoNewline; Write-Host 'Version' $v '->' $new; exit 0"

if errorlevel 1 (
  echo Could not bump version. Edit version.txt manually (e.g. 1.0.1) then run again.
  pause
  exit /b 1
)

git add version.txt download_url.txt
git commit -m "Update version"
git push origin master 2>nul
if errorlevel 1 git push origin main 2>nul

echo.
echo Pushed. Now upload the new exe on GitHub:
echo   https://github.com/%REPO%/%REPO_NAME%/releases
echo.
echo Exe path: %~dp0..\bin\user\CS2 External.exe
echo.
pause
