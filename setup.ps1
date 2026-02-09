# ============================================
# Gaurav's Website - One-Click Setup Script
# Developed by Pranjal
# Run this with: .\setup.ps1
# Requires: Admin privileges (Run as Administrator)
# ============================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Gaurav's Website - Setup Script" -ForegroundColor Cyan
Write-Host "  Developed by Pranjal" -ForegroundColor Gray
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check if running as admin
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Write-Host "[ERROR] Please run this script as Administrator!" -ForegroundColor Red
    Write-Host "Right-click PowerShell -> Run as Administrator" -ForegroundColor Yellow
    pause
    exit 1
}

# Step 1: Check if winget is available
Write-Host "[1/5] Checking for winget..." -ForegroundColor Yellow
$wingetCheck = Get-Command winget -ErrorAction SilentlyContinue
if (-not $wingetCheck) {
    Write-Host "[ERROR] winget not found. Please install App Installer from Microsoft Store." -ForegroundColor Red
    Write-Host "https://www.microsoft.com/store/productId/9NBLGGH4NNS1" -ForegroundColor Cyan
    pause
    exit 1
}
Write-Host "[OK] winget found!" -ForegroundColor Green

# Step 2: Install site engine if not present
Write-Host ""
Write-Host "[2/5] Checking for site engine..." -ForegroundColor Yellow

# Refresh PATH first
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")

$engineCheck = Get-Command hugo -ErrorAction SilentlyContinue
if (-not $engineCheck) {
    Write-Host "Site engine not found. Installing..." -ForegroundColor Yellow
    winget install Hugo.Hugo.Extended --accept-source-agreements --accept-package-agreements
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[ERROR] Failed to install site engine!" -ForegroundColor Red
        pause
        exit 1
    }
    
    # Refresh PATH after install
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Write-Host "[OK] Site engine installed successfully!" -ForegroundColor Green
} else {
    Write-Host "[OK] Site engine already installed!" -ForegroundColor Green
}

# Verify engine works
$engineVersion = hugo version 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "Engine ready" -ForegroundColor Gray
} else {
    Write-Host "[WARNING] Engine installed but may need terminal restart." -ForegroundColor Yellow
}

# Step 3: Check if Git is installed (optional, for future updates)
Write-Host ""
Write-Host "[3/5] Checking for Git..." -ForegroundColor Yellow
$gitCheck = Get-Command git -ErrorAction SilentlyContinue
if (-not $gitCheck) {
    Write-Host "Git not found. Installing Git..." -ForegroundColor Yellow
    winget install Git.Git --accept-source-agreements --accept-package-agreements
    
    # Refresh PATH
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
    
    Write-Host "[OK] Git installed!" -ForegroundColor Green
} else {
    Write-Host "[OK] Git already installed!" -ForegroundColor Green
}

# Step 4: Verify site structure
Write-Host ""
Write-Host "[4/5] Verifying site structure..." -ForegroundColor Yellow

$scriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptDir

$requiredFiles = @(
    "hugo.toml",
    "themes/hugo-coder/layouts/baseof.html"
)

$missingFiles = @()
foreach ($file in $requiredFiles) {
    if (-not (Test-Path $file)) {
        $missingFiles += $file
    }
}

if ($missingFiles.Count -gt 0) {
    Write-Host "[ERROR] Missing required files:" -ForegroundColor Red
    foreach ($file in $missingFiles) {
        Write-Host "  - $file" -ForegroundColor Red
    }
    pause
    exit 1
}

Write-Host "[OK] All required files present!" -ForegroundColor Green

# Step 5: Clean up any old build files
Write-Host ""
Write-Host "[5/5] Cleaning up old build files..." -ForegroundColor Yellow
Remove-Item -Recurse -Force public -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force resources -ErrorAction SilentlyContinue
Remove-Item .hugo_build.lock -ErrorAction SilentlyContinue
Write-Host "[OK] Cleanup complete!" -ForegroundColor Green

# All done - start the server
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  Setup Complete!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "Starting development server..." -ForegroundColor Cyan
Write-Host ""
Write-Host "Your website will be available at:" -ForegroundColor White
Write-Host "  http://localhost:1313" -ForegroundColor Cyan
Write-Host ""
Write-Host "Press Ctrl+C to stop the server." -ForegroundColor Gray
Write-Host ""

# Start server
hugo server -D

