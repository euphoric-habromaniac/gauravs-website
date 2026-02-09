@echo off
echo ========================================
echo   Gaurav's Website - Setup Launcher
echo   Developed by Pranjal
echo ========================================
echo.
echo This will set up and run your website.
echo Make sure you're running as Administrator!
echo.
pause

powershell -ExecutionPolicy Bypass -File "%~dp0setup.ps1"

pause
