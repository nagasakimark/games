@echo off
rem Double-click this file to publish your latest changes to the website.
cd /d "%~dp0"
echo.
echo  Updating the games site...
echo.

git add -A
git diff --cached --quiet
if %errorlevel%==0 goto nochange

git commit -m "Update games %date% %time%"
git pull --rebase origin main
git push origin main
if errorlevel 1 goto failed

echo.
echo  Done! The site updates in about a minute:
echo  https://nagasakimark.github.io/games/
echo.
pause
exit /b 0

:nochange
echo  Nothing has changed since the last update.
echo.
pause
exit /b 0

:failed
echo.
echo  Something went wrong - the site was NOT updated.
echo  Read the messages above (usually git is not installed or not signed in to GitHub).
echo.
pause
exit /b 1
