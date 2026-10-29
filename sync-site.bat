@echo off
setlocal EnableDelayedExpansion
rem ------------------------------------------------------------
rem  Double-click to sync this folder with the website on GitHub.
rem    - GitHub is newer      -> downloads it
rem    - You changed things   -> uploads them
rem    - BOTH changed         -> warns you and lets you choose
rem ------------------------------------------------------------
cd /d "%~dp0"
title Sync games site
echo.

git --version >nul 2>&1
if errorlevel 1 (
  echo  Git is not installed on this computer. Get it from https://git-scm.com
  goto fail
)
if not exist ".git" (
  echo  This folder is not connected to GitHub yet - there is no .git folder here.
  goto fail
)

echo  Checking GitHub...
git fetch origin main
if errorlevel 1 (
  echo.
  echo  Could not reach GitHub. Check the internet connection and that you are signed in to GitHub.
  goto fail
)

set "DIRTY=0"
for /f %%i in ('git status --porcelain') do set "DIRTY=1"
set "AHEAD=0"
for /f %%i in ('git rev-list --count origin/main..HEAD') do set "AHEAD=%%i"
set "BEHIND=0"
for /f %%i in ('git rev-list --count HEAD..origin/main') do set "BEHIND=%%i"

set "MINE=0"
if "!DIRTY!"=="1" set "MINE=1"
if not "!AHEAD!"=="0" set "MINE=1"

if "!MINE!"=="0" if "!BEHIND!"=="0" goto insync
if "!MINE!"=="0" goto download
if "!BEHIND!"=="0" goto upload
goto conflict

:insync
echo.
echo  Everything is already up to date. Nothing to do.
goto done

:download
echo.
echo  GitHub has newer changes. Downloading them...
git pull --ff-only origin main
if errorlevel 1 goto fail
echo.
echo  Done. This folder now matches the website.
goto done

:upload
echo.
echo  You have changes that are not on the website yet:
git status --short
git add -A
git diff --cached --quiet
if errorlevel 1 git commit -q -m "Update games %date% %time%"
git push origin main
if errorlevel 1 goto fail
echo.
echo  Done. The website updates in about a minute:
echo  https://nagasakimark.github.io/games/
goto done

:conflict
echo.
echo  ================================ WARNING ================================
echo   Both this computer AND GitHub have changes the other one does not have.
echo   Your files here:
git status --short
echo   GitHub has !BEHIND! newer update(s) that you do not have yet.
echo  =========================================================================
echo.
echo   [M] Merge both together (safest - tries to keep everything)
echo   [D] Use GitHub's version here (your changes are saved in a backup first)
echo   [U] Use MY version and overwrite GitHub (GitHub's is saved in a backup first)
echo   [C] Cancel, do nothing
echo.
choice /c MDUC /n /m "  Choose M, D, U or C: "
if errorlevel 4 goto cancel
if errorlevel 3 goto forceup
if errorlevel 2 goto forcedown
goto merge

:merge
git add -A
git diff --cached --quiet
if errorlevel 1 git commit -q -m "Save local changes before sync"
git pull --rebase origin main
if errorlevel 1 (
  git rebase --abort >nul 2>&1
  echo.
  echo  The two versions changed the same lines, so they could not be merged automatically.
  echo  Nothing was changed. Run this again and choose D or U.
  goto fail
)
git push origin main
if errorlevel 1 goto fail
echo.
echo  Done. Both sets of changes were merged and uploaded.
goto done

:forcedown
git add -A
git diff --cached --quiet
if errorlevel 1 git commit -q -m "Save local changes before sync"
for /f %%i in ('git rev-parse --short HEAD') do set "H=%%i"
git branch "backup-mine-!H!"
git reset --hard origin/main
if errorlevel 1 goto fail
echo.
echo  Done. This folder now matches GitHub.
echo  Your own version was kept in a backup called backup-mine-!H!
echo  (ask Claude or run  git checkout backup-mine-!H!  to get it back).
goto done

:forceup
git add -A
git diff --cached --quiet
if errorlevel 1 git commit -q -m "Update games %date% %time%"
for /f %%i in ('git rev-parse --short origin/main') do set "H=%%i"
git branch "backup-github-!H!" origin/main
git push --force-with-lease origin main
if errorlevel 1 goto fail
echo.
echo  Done. GitHub now has your version.
echo  The old GitHub version was kept in a backup called backup-github-!H!
goto done

:cancel
echo.
echo  Cancelled. Nothing was changed.
goto done

:fail
echo.
echo  *** The sync did NOT finish. Read the messages above. ***
echo.
pause
exit /b 1

:done
echo.
pause
exit /b 0
