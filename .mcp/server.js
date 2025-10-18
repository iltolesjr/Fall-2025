#!/usr/bin/env node
// prodesk86 unified academic utility + static file server (single script)
import http from 'node:http';
import { readdir, stat, readFile } from 'node:fs/promises';
import { createReadStream } from 'node:fs';
import { extname, join, resolve } from 'node:path';

// -------- Configuration --------
const HOST = process.env.PRODESK_HOST || 'prodesk86';
const PORT = Number(process.env.PRODESK_PORT || 8086);
const ROLE = process.env.REPO_ROLE || 'school';
const ROOT = resolve(process.env.REPO_PATH || '.');

// -------- Helpers --------
const MIME = {
  '.html': 'text/html; charset=utf-8',
  '.md': 'text/markdown; charset=utf-8',
  '.txt': 'text/plain; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.js': 'text/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8'
};

function sendJSON(res, code, obj) {
  res.writeHead(code, { 'Content-Type': 'application/json' });
  res.end(JSON.stringify(obj, null, 2));
}

// -------- Tool Implementations --------
async function tool_listAssignments() {
  const base = join(ROOT, 'assignments');
  let out = [];
  try {
    const entries = await readdir(base, { withFileTypes: true });
    for (const d of entries) {
      if (!d.isDirectory()) continue;
      const sub = join(base, d.name);
      const files = await readdir(sub);
      for (const f of files) {
        if (/tracker\.md$/i.test(f)) out.push({ course: d.name, tracker: f, path: join('assignments', d.name, f) });
      }
    }
  } catch (e) {
    return { error: 'scan_failed', detail: e.message };
  }
  return { assignments: out };
}

async function tool_dueDates({ days = 7 } = {}) {
  const base = join(ROOT, 'assignments');
  const cutoff = Date.now() + days * 86400000;
  const results = [];
  try {
    const files = await readdir(base);
    for (const f of files) {
      if (!f.endsWith('-tracker.md')) continue;
      const course = f.replace('-tracker.md', '');
      const content = await readFile(join(base, f), 'utf-8');
      const lines = content.split(/\r?\n/);
      for (const line of lines) {
        // naive pattern: | Assignment | YYYY-MM-DD | or similar
        const m = line.match(/\|\s*([^|]+?)\s*\|\s*(\d{4}-\d{2}-\d{2})\s*\|/);
        if (m) {
          const when = new Date(m[2]).getTime();
          if (!isNaN(when) && when <= cutoff) {
            results.push({ course, assignment: m[1].trim(), due: m[2] });
          }
        }
      }
    }
  } catch (e) {
    return { error: 'parse_failed', detail: e.message };
  }
  return { windowDays: days, upcoming: results };
}

function tool_outline({ kind = 'essay' } = {}) {
  return {
    kind,
    outline: kind === 'discussion'
      ? ['Hook (anecdote fragment)', 'Pivot/Claim', 'Evidence + mechanism', 'Synthesis', 'Forward question']
      : ['Intro (thesis last)', 'Body 1 (mechanism→effect→theme)', 'Body 2 (complication)', 'Body 3 (contrast/escalation)', 'Conclusion (return + extension)']
  };
}

function tool_voiceAdapt({ text = '', mode = 'light' } = {}) {
  if (!text.trim()) return { original: text, adapted: '', note: 'empty' };
  let adapted = text.replace(/\s+/g, ' ').trim();
  if (!/[.!?]$/.test(adapted)) adapted += '.';
  if (mode === 'academic') adapted = adapted.replace(/^\b(And|But|So)\b\s+/i, '');
  return { original: text, adapted, mode };
}

function tool_studySchedule({ start }) {
  if (!start) return { error: 'missing_start', hint: 'Provide start=YYYY-MM-DD' };
  const weekStart = new Date(start);
  if (isNaN(weekStart.getTime())) return { error: 'bad_date' };
  const blocks = [];
  for (let i = 0; i < 7; i++) {
    const d = new Date(weekStart); d.setDate(weekStart.getDate() + i);
    const label = d.toLocaleDateString('en-US', { weekday: 'long' });
    blocks.push({ day: label, date: d.toISOString().slice(0,10), plan: ['Review prior notes (30m)', 'Focused assignment block (60–90m)', 'Light preview next topic (20m)'] });
  }
  return { start, schedule: blocks };
}

function tool_notesTemplate({ format = 'outline', course = '', topic = '' } = {}) {
  const header = `# ${format.charAt(0).toUpperCase()+format.slice(1)} Notes${course?` – ${course}`:''}${topic?` – ${topic}`:''}`;
  const templates = {
    cornell: `${header}\n\n## Cue Column | Notes Column\n### Questions / Keywords | Details / Explanations\n\n---\n\n### Summary\nKey takeaways...`,
    outline: `${header}\n\nI. Main Point\n   A. Subpoint\n      1. Detail\n\nII. Next Point\n`,
    summary: `${header}\n\n## Key Concepts\n1. ...\n2. ...\n\n## Details\n- ...\n- ...\n\n## Questions\n1. ...\n`,
    mindmap: `${header}\n\nCentral: [Topic]\n- Branch 1: details\n- Branch 2: details\n- Branch 3: details\n`
  };
  return { format, template: templates[format] || templates.outline };
}

// Registry mapping
const TOOL_REGISTRY = {
  ping: () => ({ ok: true, host: HOST, role: ROLE, time: new Date().toISOString() }),
  assignments: tool_listAssignments,
  due: tool_dueDates,
  outline: tool_outline,
  voice: tool_voiceAdapt,
  study: tool_studySchedule,
  notes: tool_notesTemplate
};

// -------- HTTP Router --------
async function handleApi(pathname, searchParams, res) {
  const name = pathname.slice('/api/'.length);
  const fn = TOOL_REGISTRY[name];
  if (!fn) return sendJSON(res, 404, { error: 'unknown_tool', tool: name });
  const args = Object.fromEntries(searchParams.entries());
  try {
    const data = await fn(args);
    return sendJSON(res, 200, data);
  } catch (e) {
    return sendJSON(res, 500, { error: 'tool_error', detail: e.message });
  }
}

async function serveStatic(pathname, res) {
  let pth = decodeURIComponent(pathname);
  if (pth === '/') pth = '/README.md';
  const filePath = join(ROOT, pth);
  try {
    const st = await stat(filePath);
    if (st.isDirectory()) {
      res.writeHead(403, { 'Content-Type': 'text/plain; charset=utf-8' });
      return res.end('Directory browsing disabled');
    }
    const ext = extname(filePath).toLowerCase();
    res.writeHead(200, { 'Content-Type': MIME[ext] || 'application/octet-stream' });
    createReadStream(filePath).pipe(res);
  } catch {
    res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
    res.end('Not found');
  }
}

function requestListener(req, res) {
  const url = new URL(req.url, `http://${req.headers.host}`);
  if (url.pathname.startsWith('/api/')) return void handleApi(url.pathname, url.searchParams, res);
  return void serveStatic(url.pathname, res);
}

http.createServer(requestListener).listen(PORT, HOST, () => {
  console.log(`[prodesk86] unified server http://${HOST}:${PORT} role=${ROLE}`);
  console.log('Tools:', Object.keys(TOOL_REGISTRY).join(', '));
  console.log('Example: /api/outline?kind=discussion');
});