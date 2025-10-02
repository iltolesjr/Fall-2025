# prodesk86 Unified Academic Server – API Guide

This document describes the lightweight HTTP API exposed by `.mcp/server.js`.

Base URL (default): `http://prodesk86:8086`

Environment variables you can set before launching:
- `PRODESK_HOST` (default `prodesk86`)
- `PRODESK_PORT` (default `8086`)
- `REPO_ROLE`  (e.g. `school`, `genealogy`)
- `REPO_PATH`  (root folder to serve / scan; default `.`)

---
## Endpoints Overview
| Endpoint | Purpose | Query Parameters | Returns |
|----------|---------|------------------|---------|
| `/api/ping` | Health + context check | *(none)* | `{ ok, host, role, time }` |
| `/api/assignments` | Scan assignment trackers | *(none)* | `{ assignments:[{course,tracker,path}] }` |
| `/api/due` | Extract upcoming due dates | `days` (int, optional, default 7) | `{ windowDays, upcoming:[{course,assignment,due}] }` |
| `/api/outline` | Get structural outline template | `kind` (`essay`|`discussion`) | `{ kind, outline:[...] }` |
| `/api/voice` | Light voice adaptation | `text` (string), `mode` (`light`|`academic`) | `{ original, adapted, mode }` |
| `/api/study` | 7‑day study schedule scaffold | `start` (`YYYY-MM-DD`) | `{ start, schedule:[{day,date,plan[]}] }` |
| `/api/notes` | Note template generator | `format` (`outline`|`cornell`|`summary`|`mindmap`), `course`, `topic` | `{ format, template }` |

Static file serving: Any non `/api/` path serves a file from `REPO_PATH`. Root `/` defaults to `README.md`.

---
## Usage Examples (PowerShell)
```powershell
# Ping
Invoke-RestMethod http://prodesk86:8086/api/ping

# Discussion outline
Invoke-RestMethod 'http://prodesk86:8086/api/outline?kind=discussion'

# Voice adaptation (URL-encode spaces automatically by quoting)
Invoke-RestMethod "http://prodesk86:8086/api/voice?text=im%20writing%20something&mode=academic"

# Due dates within 10 days
Invoke-RestMethod 'http://prodesk86:8086/api/due?days=10'

# Study schedule for week starting 2025-10-06
Invoke-RestMethod 'http://prodesk86:8086/api/study?start=2025-10-06'

# Cornell notes template for ENGL 1110, Chapter1
Invoke-RestMethod 'http://prodesk86:8086/api/notes?format=cornell&course=ENGL%201110&topic=Ch1'
```

### Curl (optional) (Git Bash / WSL / Linux)
```bash
curl http://prodesk86:8086/api/ping
curl "http://prodesk86:8086/api/voice?text=structure%20matters&mode=light"
```

---
## Response Shapes
### Ping
```json
{ "ok": true, "host": "prodesk86", "role": "school", "time": "2025-10-01T12:34:56.789Z" }
```

### Assignments
```json
{
  "assignments": [
    { "course": "ENGL-1110", "tracker": "ENGL-1110-tracker.md", "path": "assignments/ENGL-1110/ENGL-1110-tracker.md" }
  ]
}
```

### Due Dates
```json
{
  "windowDays": 7,
  "upcoming": [ { "course": "ENGL-1110", "assignment": "Essay 1", "due": "2025-10-05" } ]
}
```

### Outline (discussion)
```json
{
  "kind": "discussion",
  "outline": [
    "Hook (anecdote fragment)",
    "Pivot/Claim",
    "Evidence + mechanism",
    "Synthesis",
    "Forward question"
  ]
}
```

### Voice
```json
{ "original": "im writing something", "adapted": "im writing something.", "mode": "light" }
```

### Study Schedule
Truncated example:
```json
{
  "start": "2025-10-06",
  "schedule": [ { "day": "Monday", "date": "2025-10-06", "plan": ["Review prior notes (30m)", "Focused assignment block (60–90m)", "Light preview next topic (20m)"] } ]
}
```

### Notes Template
```json
{ "format": "outline", "template": "# Outline Notes – ENGL 1110 – Chapter 1\n\nI. Main Point\n..." }
```

---
## Error Conventions
Errors return HTTP 4xx/5xx with JSON body:
```json
{ "error": "unknown_tool", "tool": "xyz" }
```
Common error keys:
- `unknown_tool` – invalid `/api/` name
- `tool_error` – internal exception
- `missing_start` / `bad_date` – schedule input issues
- `scan_failed` / `parse_failed` – file system or parsing problems

---
## Extension Ideas (Future)
- `/api/summarize?file=...` to produce a condensed study recap
- `/api/thesis-seeds?chapter=1` deriving seeds from a notes file
- POST endpoints (switch to body parsing) for saving user annotations
- WebSocket push for due date reminders

---
## Launch (PowerShell)
```powershell
$env:PRODESK_PORT=8086
$env:REPO_ROLE='school'
node .\.mcp\server.js
```

---
Last updated: 2025-10-01
