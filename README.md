# CivicAI – From Report to Action
> **AI-Powered Smart Civic Issue Intelligence & Action Platform**  
> *Developed for PromptWar Hackathon*

---

## 1. Product Vision & Architecture

CivicAI transforms scattered citizen complaints into intelligent, prioritized, and trackable civic action. Rather than a static reporting portal or a superficial dashboard, CivicAI delivers an **end-to-end, production-grade intelligence pipeline** satisfying all four core pillars of smart civic governance:

```
┌────────────────┐     ┌────────────────┐     ┌────────────────┐     ┌────────────────┐
│   1. CAPTURE   │ ──► │ 2. UNDERSTAND  │ ──► │   3. REVEAL    │ ──► │     4. ACT     │
│  Mobile Form   │     │ AI Triage &    │     │ GIS Hotspots & │     │  Dispatch &    │
│  GPS & Media   │     │ 0–100 Scoring  │     │ Duplicate TFIDF│     │  Citizen Audit │
└────────────────┘     └────────────────┘     └────────────────┘     └────────────────┘
```

1. **Capture**: 60-second mobile-first citizen submission, GPS coordinates auto-detection, local media upload with security validation, and instant generation of unguessable tracking tokens (`TRK-XXXX-YYYY`).
2. **Understand**: Real multimodal AI processing (Google Gemini API support + pure Python NLP fallback). Categorizes issues across 8 civic verticals, outputs 2-line executive summaries, and transparently computes an explainable 0–100 priority score.
3. **Reveal**: Geospatial radius clustering (DBSCAN/Haversine) uncovering hidden problem corridors; TF-IDF and cosine semantic similarity matching potential duplicate complaints across space and time.
4. **Act**: Complete municipal command center with real-time KPI metrics, Recharts analytics, department/worker dispatching, status transitions, and public citizen tracking.

---

## 2. Tech Stack

- **Frontend**:
  - React 18, TypeScript, Vite
  - Tailwind CSS (Dark Navy & Electric Blue command-center theme)
  - React Router DOM v6
  - Recharts (Donut, Line, and Bar analytics)
  - Leaflet & OpenStreetMap (interactive color-coded priority pins and hotspot overlays)
  - Lucide React Icons
- **Backend**:
  - Python FastAPI (REST APIs with automated Swagger documentation)
  - SQLAlchemy ORM & SQLite persistent storage
  - Pydantic v2 data validation schemas
  - Local secure file upload pipeline
- **AI / ML Intelligence Engine**:
  - Pure-Python TF-IDF vectorizer and cosine similarity (zero binary dependencies)
  - Haversine spatial distance metric
  - 5-factor explainable priority engine (Safety Risk, Urgency, Population Affected, Geographic Importance, Frequency Surge)
  - Optional Google Gemini 1.5 Flash API integration with automatic fallback

---

## 3. Project Structure

```
project1/
├── backend/
│   ├── app/
│   │   ├── __init__.py
│   │   ├── main.py              # FastAPI app & CORS configuration
│   │   ├── config.py            # Environment configuration
│   │   ├── database.py          # SQLAlchemy SQLite connection
│   │   ├── models.py            # Report & TimelineEvent models
│   │   ├── schemas.py           # Pydantic validation schemas
│   │   ├── ai_engine.py         # AI categorization, TF-IDF, clustering, explainable scoring
│   │   ├── seed_data.py         # 50 realistic synthetic reports
│   │   └── routers/
│   │       ├── reports.py       # CRUD, upload & tracking APIs
│   │       ├── ai.py            # Triage, duplicates & hotspots APIs
│   │       └── dashboard.py     # KPIs & auth APIs
│   ├── uploads/                 # Local image upload storage
│   ├── requirements.txt
│   └── seed.py                  # Idempotent synthetic data seeder
├── frontend/
│   ├── src/
│   │   ├── components/          # Navbar, Footer, Logo, MapView, Badges
│   │   ├── pages/
│   │   │   ├── LandingPage.tsx          # Startup hero & 4-pillar showcase
│   │   │   ├── CitizenHome.tsx          # Citizen portal & active hazard alert
│   │   │   ├── SubmitReport.tsx         # 1-minute submission with live AI preview
│   │   │   ├── TrackComplaint.tsx       # Citizen status audit timeline
│   │   │   ├── AdminLogin.tsx           # Superintendent auth
│   │   │   ├── AdminDashboard.tsx       # Municipal command center with charts
│   │   │   ├── ComplaintManagement.tsx  # Workflows, duplicate links & dispatch
│   │   │   ├── InteractiveMapPage.tsx   # Leaflet GIS map with hotspot radar
│   │   │   ├── AIIntelligencePage.tsx   # AI sandbox, duplicate matrix & radar
│   │   │   └── ComplaintDetails.tsx     # Standalone deep investigation view
│   │   ├── context/AuthContext.tsx
│   │   ├── services/api.ts
│   │   └── types/index.ts
│   ├── package.json
│   ├── vite.config.ts
│   └── tailwind.config.js
├── run_demo.bat                 # One-click Windows launch script
├── run_demo.ps1                 # One-click PowerShell launch script
├── .env.example
└── README.md
```

---

## 4. Quick Start & Setup Instructions

### Prerequisites
- Python 3.10+ (Python 3.14 compatible)
- Node.js 18+ (Node.js 20 installed in `.tools/node`)

### One-Click Launch (Windows)
Double-click `run_demo.bat` or run in PowerShell:
```powershell
.\run_demo.ps1
```

### Manual Launch

#### 1. Backend Setup
```powershell
# Navigate to project root
& ".\.venv\Scripts\python.exe" -m pip install -r backend\requirements.txt

# Seed the database with 50 realistic synthetic reports
& ".\.venv\Scripts\python.exe" backend\seed.py --force

# Launch FastAPI server
$env:PYTHONPATH = "backend"
& ".\.venv\Scripts\python.exe" -m uvicorn app.main:app --host 127.0.0.1 --port 8000 --reload
```
*Backend Swagger Docs will be live at `http://127.0.0.1:8000/docs`.*

#### 2. Frontend Setup
```powershell
# In a second terminal
cd frontend
$env:PATH = "$pwd\..\.tools\node;$env:PATH"
npm install
npm run dev
```
*Frontend will be live at `http://localhost:5173`.*

---

## 5. Demo Credentials

| Role | Email | Password | Access Level |
| :--- | :--- | :--- | :--- |
| **Superintendent Administrator** | `admin@civicai.gov` | `admin123` | Full Municipal Command Center |
| **Public Citizen** | *No login needed* | *No login needed* | Submit reports & track with `TRK-XXXX` tokens |

*(The Admin Login page also includes a "One-Click Demo Admin Sign-In" button for instantaneous evaluation).*

---

## 6. REST API Documentation

| Method | Endpoint | Description |
| :--- | :--- | :--- |
| `POST` | `/api/reports` | Submit report, trigger AI triage, return complaint code & tracking token |
| `GET` | `/api/reports` | List reports with multi-criteria filters (status, category, priority, search) |
| `GET` | `/api/reports/{id}` | Complete report investigation file with timeline history |
| `GET` | `/api/track/{code}` | Citizen tracking endpoint (redacts private citizen contact info) |
| `POST` | `/api/upload` | Secure image upload endpoint with extension & size validation |
| `PATCH`| `/api/reports/{id}/status` | Update complaint status and append audit timeline event |
| `PATCH`| `/api/reports/{id}/assign` | Assign complaint to department & field crew |
| `PATCH`| `/api/reports/{id}/duplicate` | Confirm or reject duplicate correlation links |
| `PATCH`| `/api/reports/{id}/notes` | Save protected internal administrative notes |
| `POST` | `/api/ai/analyze` | On-demand AI triage (category, confidence, 0–100 score, summary, brief) |
| `GET` | `/api/ai/duplicates/{id}` | Return TF-IDF semantic duplicate candidates with distance & % match |
| `GET` | `/api/ai/hotspots` | Return geographic clusters with suggested municipal interventions |
| `GET` | `/api/ai/insights` | Synthesize live strategic observations directly from active DB |
| `GET` | `/api/dashboard/stats` | Aggregated KPIs, category donut data, and timeline inflow trends |
| `POST` | `/api/auth/login` | Simple demo authentication mechanism for admin operations |

---

## 7. Five-Minute Hackathon Demonstration Script

### Minute 1: The Vision & Citizen Capture
1. Open `http://localhost:5173` to showcase the **Landing Page**. Point out the 4-stage lifecycle (Capture, Understand, Reveal, Act) and the live telemetry metrics.
2. Click **"Report Civic Issue"** to open the 1-minute submission form:
   - Type in: *"High voltage 440V cable snapped and dangling near children playground with active sparking!"*
   - Notice the **Live AI Auto-Detection indicator** immediately categorizing it as **Public Safety** with a high predicted priority score before even clicking submit!
   - Click **"GPS Auto-Detect"** to simulate geo-pinning.
   - Click **"Submit Civic Report"**.
   - Show the generated confirmation modal with the unique Complaint ID (`CIV-2026-1051`) and secret tracking token (`TRK-XXXX-YYYY`).

### Minute 2: Citizen Tracking & Transparency
1. Click **"Track Status Now"** (or open `http://localhost:5173/track`).
2. Show how the citizen can enter their tracking token to view the full lifecycle progression bar (Submitted &rarr; Under Review &rarr; Assigned &rarr; In Progress &rarr; Resolved).
3. Point out the **Status Update Audit Timeline** recording the exact AI triage rationale and timestamp.

### Minute 3: Municipal Command Center
1. Click **"Command Center"** in the navigation bar (or sign in via `admin@civicai.gov`).
2. Highlight the top 5 operational counters (Total Reports, Pending, In Progress, Critical Hazards, Resolved).
3. Review the **Category Distribution Donut Chart**, **Complaint Trends Line Chart**, and **Resolution Health Bar Chart** rendered dynamically via Recharts.
4. Show the **Live AI Insights Feed** synthesizing strategic alerts (e.g. *"Concentrated Hotspot: Central Bus Stand Underpass"*, *"6 High-Risk Safety Hazards Detected"*).

### Minute 4: Interactive GIS Map & Hotspot Radar
1. Click **"GIS Map"** in the navigation.
2. Demonstrate the Leaflet OpenStreetMap with custom color-coded pins:
   - **Red**: Critical (80–100)
   - **Orange**: High (60–79)
   - **Blue**: Medium (35–59)
   - **Green**: Low (0–34)
3. Toggle the **"Hotspot Overlays"** to display geographic problem clusters (e.g., Central Station & Flower Market), showing the calculated cluster radius, top category, and suggested municipal engineering action.
4. Click any pin to open its inspection card and deep-link directly into management.

### Minute 5: Complaints Management, Duplicate Linking & Field Action
1. Open **"Management"** (`/admin/complaints`).
2. Click on a complaint (e.g. `CIV-2026-1002`) to slide open the **Action Workflow Drawer**:
   - Inspect the **AI Triage Report** showing category confidence and 2-line summary.
   - Show the **Correlated Duplicates panel**: the TF-IDF engine detected that `CIV-2026-1002` is an 88% semantic match located 24 meters away from `CIV-2026-1001` (crater on MG Road).
   - Click **"Confirm & Link Duplicate"** to avoid sending duplicate road crews!
   - Select **"Road Maintenance"** from the department dropdown, enter a field crew unit, update status to **"In Progress"**, and add a resolution note.
   - Save and return to the Citizen Tracking page to show that the citizen's view was updated in real time!

---

## 8. Synthetic Demonstration Dataset Summary
- **Total Seeded Reports**: 50 realistic complaints
- **Critical Safety Incidents**: 6 (live wires, hospital entrance cave-in, open 12ft sewer drop, transformer hazard)
- **Deliberate Duplicate Groups**: 5 groups (MG Road crater, underpass flood, flower market trash heap, ring road blackout, water pipe burst)
- **Geographic Hotspots**: 3 distinct clusters with calculated centroids and recommended actions
- **Seed Script**: `python backend/seed.py --force` (idempotent, safe to re-run).
