@echo off
echo ========================================
echo   Gaurav's Website
echo   Developed by Pranjal
echo ========================================
echo.
echo Website will be at: http://localhost:1313
echo Press Ctrl+C to stop.
echo.

cd /d "%~dp0"
hugo server -D

pause
