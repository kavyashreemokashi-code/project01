@echo off
echo ========================================================
echo   CivicAI - From Report to Action
echo   Starting Backend (FastAPI) and Frontend (Vite)
echo ========================================================

:: Add portable Node.js to PATH
set PATH=%~dp0.tools\node;%PATH%

:: Start Backend in separate window with PYTHONPATH set
start "CivicAI Backend (FastAPI:8000)" cmd /k "cd /d %~dp0 && set PYTHONPATH=backend && .venv\Scripts\python.exe -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload"

:: Wait briefly for backend to initialize
timeout /t 3 /nobreak > nul

:: Start Frontend in separate window
start "CivicAI Frontend (Vite:5173)" cmd /k "cd /d %~dp0frontend && set PATH=%~dp0.tools\node;%PATH% && npm run dev"

echo.
echo [OK] Both servers launched in separate windows!
echo.
echo   Citizen Portal ^& Landing Page : http://localhost:5173
echo   Municipal Command Center       : http://localhost:5173/admin
echo   Backend Swagger API Docs       : http://127.0.0.1:8000/docs
echo   Demo Admin Account             : admin@civicai.gov / admin123
echo.
echo ========================================================
