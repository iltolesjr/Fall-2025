#!/usr/bin/env node
// prodesk86 unified academic utility + static file server (single script)
import http from 'node:http';
import { readdir, stat, readFile } from 'node:fs/promises';
import { createReadStream } from 'node:fs';
import { extname, join, resolve, sep, dirname } from 'node:path';
import { createGzip, createBrotliCompress } from 'node:zlib';

// -------- Configuration --------
const HOST = process.env.PRODESK_HOST || '0.0.0.0';
const PORT = Number(process.env.PRODESK_PORT || 8086);
const ROLE = process.env.REPO_ROLE || 'school';
const ROOT = resolve(process.env.REPO_PATH || '.');

// -------- Helpers --------
const MIME = {
  '.html': 'text/html; charset=utf-8',
  '.md': 'text/markdown; charset=utf-8',
  '.txt': 'text/plain; charset=utf-8',
  '.json': 'application/json; charset=utf-8',
  '.js': 'application/javascript; charset=utf-8',
  '.mjs': 'application/javascript; charset=utf-8',
  '.css': 'text/css; charset=utf-8',
  '.svg': 'image/svg+xml',
  '.png': 'image/png',
  '.jpg': 'image/jpeg',
  '.jpeg': 'image/jpeg',
  '.gif': 'image/gif',
  '.ico': 'image/x-icon',
  '.webp': 'image/webp',
  '.wasm': 'application/wasm',
  '.pdf': 'application/pdf',
  '.xml': 'application/xml; charset=utf-8'
};

const TEXT_LIKE = new Set([
  '.html', '.md', '.txt', '.json', '.js', '.mjs', '.css', '.svg', '.xml'
]);

function sendJSON(res, code, obj, extraHeaders = {}) {
  res.writeHead(code, {
    'Content-Type': 'application/json; charset=utf-8',
    'Cache-Control': 'no-store',
    ...extraHeaders
  });
  res.end(JSON.stringify(obj, null, 2));
}

function sanitizeLeadingSlash(p) {
  return p.replace(/^\/+/, '');
}

function insideRoot(absPath) {
  const r = ROOT.endsWith(sep) ? ROOT : ROOT + sep;
  const a = absPath.endsWith(sep) ? absPath : absPath;
  return a === ROOT || a.startsWith(r);
}

async function ensureFilePath(urlPath) {
  // Map URL path -> safe absolute file path under ROOT
  let pth = decodeURIComponent(urlPath);
  if (pth === '/') pth = '/README.md';
  let rel = sanitizeLeadingSlash(pth);
  let abs = resolve(ROOT, rel);

  if (!insideRoot(abs)) {
    const err = new Error('Forbidden');
    err.code = 403;
    throw err;
  }

  let st;
  try {
    st = await stat(abs);
    if (st.isDirectory()) {
      // Try index.html then README.md inside directory
      const tryIndex = resolve(abs, 'index.html');
      const tryReadme = resolve(abs, 'README.md');
      try {
        await stat(tryIndex);
        abs = tryIndex;
      } catch {
        try {
          await stat(tryReadme);
          abs = tryReadme;
        } catch {
          const err = new Error('Directory browsing disabled');
          err.code = 403;
          throw err;
        }
      }
    }
  } catch (e) {
    const err = new Error('Not found');
    err.code = 404;
    throw err;
  }
  return abs;
}

function etagFromStat(st) {
  return `"${Number(st.mtimeMs).toString(16)}-${st.size.toString(16)}"`;
}

function acceptsEncoding(req, name) {
  const ae = req.headers['accept-encoding'] || '';
  return ae.includes(name);
}

function corsHeaders() {
  return {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET,HEAD,OPTIONS',
    'Access-Control-Allow-Headers': 'Content-Type'
  };
}

// -------- File walkers --------
async function* walk(dir) {
  let entries;
  try {
    entries = await readdir(dir, { withFileTypes: true });
  } catch {
    return;
  }
  for (const ent of entries) {
    const fp = join(dir, ent.name);
    if (ent.isDirectory()) {
      yield* walk(fp);
    } else {
      yield fp;
    }
  }
}

// -------- Tool Implementations --------
async function tool_listAssignments() {
  const base = join(ROOT, 'assignments');
  const out = [];
  try {
    for await (const fp of walk(base)) {
      const name = fp.toLowerCase();
      if (name.endsWith('tracker.md') || /-tracker\.md$/i.test(name)) {
        const rel = fp.slice(ROOT.length + 1).replace(/\\/g, '/');
        const parts = rel.split('/');
        const course = parts.length > 1 ? parts[1] : parts[0];
        out.push({ course, tracker: parts[parts.length - 1], path: rel });
      }
    }
  } catch (e) {
    return { error: 'scan_failed', detail: e.message };
  }
  return { assignments: out.sort((a, b) => a.course.localeCompare(b.course) || a.path.localeCompare(b.path)) };
}

async function tool_dueDates({ days } = {}) {
  let windowDays = Number(days ?? 7);
  if (!Number.isFinite(windowDays) || windowDays < 0) windowDays = 7;

  const base = join(ROOT, 'assignments');
  const cutoff = Date.now() + windowDays * 86400000;
  const results = [];

  const tableRe = /\|\s*([^|]+?)\s*\|\s*(\d{4}-\d{2}-\d{2})\s*\|/;
  const dateRe = /\b(\d{4}-\d{2}-\d{2})\b/;

  try {
    for await (const fp of walk(base)) {
      const lower = fp.toLowerCase();
      if (!(lower.endsWith('tracker.md') || /-tracker\.md$/i.test(lower))) continue;

      const rel = fp.slice(ROOT.length + 1).replace(/\\/g, '/');
      const parts = rel.split('/');
      const course = parts.length > 1 ? parts[1] : parts[0];

      const content = await readFile(fp, 'utf-8');
      const lines = content.split(/\r?\n/);
      for (const raw of lines) {
        const line = raw.trim();
        let assignment = null;
        let date = null;

        const mTable = line.match(tableRe);
        if (mTable) {
          assignment = mTable[1].trim();
          date = mTable[2];
        } else {
          const mDate = line.match(dateRe);
          if (mDate) {
            date = mDate[1];
            // Heuristic: take text before the date, or after if before is empty
            const idx = line.indexOf(date);
            let candidate = line.slice(0, idx).replace(/^[\-\*\d\.\)\s]+/, '').trim();
            if (!candidate) candidate = line.slice(idx + date.length).replace(/^[\-\*\–—:|>\s]+/, '').trim();
            assignment = candidate || 'Untitled';
          }
        }

        if (date) {
          const when = new Date(date).getTime();
          if (!isNaN(when) && when <= cutoff) {
            results.push({ course, assignment, due: date, source: rel });
          }
        }
      }
    }
  } catch (e) {
    return { error: 'parse_failed', detail: e.message };
  }
  results.sort((a, b) => a.due.localeCompare(b.due) || a.course.localeCompare(b.course));
  return { windowDays, count: results.length, upcoming: results };
}

function tool_outline({ kind = 'essay' } = {}) {
  return {
    kind,
    outline:
      kind === 'discussion'
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
    blocks.push({
      day: label,
      date: d.toISOString().slice(0, 10),
      plan: ['Review prior notes (30m)', 'Focused assignment block (60–90m)', 'Light preview next topic (20m)']
    });
  }
  return { start, schedule: blocks };
}

function tool_notesTemplate({ format = 'outline', course = '', topic = '' } = {}) {
  const header = `# ${format.charAt(0).toUpperCase() + format.slice(1)} Notes${course ? ` – ${course}` : ''}${topic ? ` – ${topic}` : ''}`;
  const templates = {
    cornell: `${header}\n\n## Cue Column | Notes Column\n### Questions / Keywords | Details / Explanations\n\n---\n\n### Summary\nKey takeaways...`,
    outline: `${header}\n\nI. Main Point\n   A. Subpoint\n      1. Detail\n\nII. Next Point\n`,
    summary: `${header}\n\n## Key Concepts\n1. ...\n2. ...\n\n## Details\n- ...\n- ...\n\n## Questions\n1. ...\n`,
    'mind-map': `${header}\n\nCentral: [Topic]\n- Branch 1: details\n- Branch 2: details\n- Branch 3: details\n`,
    mindmap: `${header}\n\nCentral: [Topic]\n- Branch 1: details\n- Branch 2: details\n- Branch 3: details\n`
  };
  const tpl = templates[format] || templates.outline;
  return { format, template: tpl };
}

function tool_help() {
  return {
    ok: true,
    host: HOST,
    role: ROLE,
    tools: Object.keys(TOOL_REGISTRY),
    examples: [
      '/api/ping',
      '/api/assignments',
      '/api/due?days=14',
      '/api/outline?kind=discussion',
      '/api/voice?mode=academic&text=And%20this%20is%20a%20draft',
      '/api/study?start=2025-09-01',
      '/api/notes?format=cornell&course=Biology&topic=Cells'
    ]
  };
}

// Registry mapping
const TOOL_REGISTRY = {
  ping: () => ({ ok: true, host: HOST, role: ROLE, time: new Date().toISOString() }),
  help: tool_help,
  assignments: tool_listAssignments,
  due: tool_dueDates,
  outline: tool_outline,
  voice: tool_voiceAdapt,
  study: tool_studySchedule,
  notes: tool_notesTemplate
};

// -------- HTTP Router --------
async function handleApi(req, pathname, searchParams, res) {
  if (req.method === 'OPTIONS') {
    res.writeHead(204, { ...corsHeaders() });
    return res.end();
  }
  if (req.method !== 'GET' && req.method !== 'HEAD') {
    return sendJSON(res, 405, { error: 'method_not_allowed' }, corsHeaders());
  }

  const name = pathname.slice('/api/'.length);
  const fn = TOOL_REGISTRY[name];
  if (!fn) return sendJSON(res, 404, { error: 'unknown_tool', tool: name }, corsHeaders());

  // Collect args from query
  const args = Object.fromEntries(searchParams.entries());
  try {
    const data = await fn(args);
    const body = JSON.stringify(data, null, 2);
    const headers = { ...corsHeaders() };
    if (req.method === 'HEAD') {
      res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8', ...headers });
      return res.end();
    }
    res.writeHead(200, { 'Content-Type': 'application/json; charset=utf-8', 'Cache-Control': 'no-store', ...headers });
    res.end(body);
  } catch (e) {
    return sendJSON(res, 500, { error: 'tool_error', detail: e.message }, corsHeaders());
  }
}

async function serveStatic(req, pathname, res) {
  let filePath;
  try {
    filePath = await ensureFilePath(pathname);
  } catch (e) {
    const code = e.code || 500;
    res.writeHead(code, { 'Content-Type': 'text/plain; charset=utf-8' });
    return res.end(code === 403 ? 'Forbidden' : 'Not found');
  }

  let st;
  try {
    st = await stat(filePath);
  } catch {
    res.writeHead(404, { 'Content-Type': 'text/plain; charset=utf-8' });
    return res.end('Not found');
  }

  const ext = extname(filePath).toLowerCase();
  const etag = etagFromStat(st);

  // Conditional GET
  if ((req.headers['if-none-match'] || '') === etag) {
    res.writeHead(304, { ETag: etag });
    return res.end();
  }

  const baseHeaders = {
    'Content-Type': MIME[ext] || 'application/octet-stream',
    'Content-Length': st.size,
    'Last-Modified': st.mtime.toUTCString(),
    'ETag': etag,
    'Cache-Control': TEXT_LIKE.has(ext) ? 'no-cache' : 'public, max-age=86400'
  };

  // Compression for text-like
  const canBrotli = TEXT_LIKE.has(ext) && acceptsEncoding(req, 'br');
  const canGzip = TEXT_LIKE.has(ext) && acceptsEncoding(req, 'gzip');

  if (req.method === 'HEAD') {
    res.writeHead(200, baseHeaders);
    return res.end();
  }

  if (canBrotli) {
    const headers = { ...baseHeaders };
    delete headers['Content-Length'];
    headers['Content-Encoding'] = 'br';
    res.writeHead(200, headers);
    createReadStream(filePath).pipe(createBrotliCompress()).pipe(res);
    return;
  }
  if (canGzip) {
    const headers = { ...baseHeaders };
    delete headers['Content-Length'];
    headers['Content-Encoding'] = 'gzip';
    res.writeHead(200, headers);
    createReadStream(filePath).pipe(createGzip()).pipe(res);
    return;
  }

  res.writeHead(200, baseHeaders);
  createReadStream(filePath).pipe(res);
}

function requestListener(req, res) {
  try {
    const url = new URL(req.url, `http://${req.headers.host || 'localhost'}`);
    if (url.pathname.startsWith('/api/')) return void handleApi(req, url.pathname, url.searchParams, res);
    if (req.method === 'OPTIONS') {
      res.writeHead(204, {});
      return res.end();
    }
    return void serveStatic(req, url.pathname, res);
  } catch (e) {
    sendJSON(res, 500, { error: 'server_error', detail: String(e?.message || e) });
  }
}

http.createServer(requestListener).listen(PORT, HOST, () => {
  console.log(`[prodesk86] unified server http://${HOST}:${PORT} role=${ROLE} root=${ROOT}`);
  console.log('Tools:', Object.keys(TOOL_REGISTRY).join(', '));
  console.log('Example: /api/outline?kind=discussion');
});