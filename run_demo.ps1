# CivicAI Launch Script (PowerShell)
# Run with: powershell -ExecutionPolicy Bypass -File run_demo.ps1

$root = $PSScriptRoot
if (-not $root) { $root = Split-Path -Parent $MyInvocation.MyCommand.Path }

Write-Host "========================================================" -ForegroundColor Cyan
Write-Host "  CivicAI - From Report to Action" -ForegroundColor Green
Write-Host "  Starting Backend (FastAPI) and Frontend (Vite)" -ForegroundColor Cyan
Write-Host "========================================================" -ForegroundColor Cyan
Write-Host ""

# Start Backend in new window
$backendCmd = "cd '$root'; `$env:PYTHONPATH = 'backend'; & '.\.venv\Scripts\python.exe' -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $backendCmd

Write-Host "[1/2] Backend server starting on http://127.0.0.1:8000 ..." -ForegroundColor Yellow
Start-Sleep -Seconds 3

# Start Frontend in new window
$nodeDir = "$root\.tools\node"
$frontendCmd = "`$env:PATH = '$nodeDir;' + `$env:PATH; cd '$root\frontend'; npm run dev"
Start-Process powershell -ArgumentList "-NoExit", "-Command", $frontendCmd

Write-Host "[2/2] Frontend server starting on http://localhost:5173 ..." -ForegroundColor Yellow
Write-Host ""
Write-Host "[OK] Both servers launched in separate windows!" -ForegroundColor Green
Write-Host ""
Write-Host "  Citizen Portal & Landing Page : http://localhost:5173" -ForegroundColor Cyan
Write-Host "  Municipal Command Center       : http://localhost:5173/admin" -ForegroundColor Cyan
Write-Host "  Submit a Report                : http://localhost:5173/citizen/report" -ForegroundColor Cyan
Write-Host "  Track Complaint                : http://localhost:5173/citizen/track" -ForegroundColor Cyan
Write-Host "  Interactive GIS Map            : http://localhost:5173/map" -ForegroundColor Cyan
Write-Host "  AI Intelligence & Insights     : http://localhost:5173/ai-insights" -ForegroundColor Cyan
Write-Host "  Backend Swagger API Docs       : http://127.0.0.1:8000/docs" -ForegroundColor Cyan
Write-Host ""
Write-Host "  Demo Admin Account: admin@civicai.gov / admin123" -ForegroundColor Magenta
Write-Host "  Sample Tracking Code: CIV-2026-1007 (Critical: Live Wire)" -ForegroundColor Magenta
Write-Host ""
Write-Host "========================================================" -ForegroundColor Cyan
