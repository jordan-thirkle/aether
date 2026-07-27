# Aether

**Professional harness for AI web development.**

Forces intentional design decisions and enforces WCAG 2.2 AA, Core Web Vitals, Nielsen heuristics, modern CSS, and anti-AI-slop rules so every AI-assisted website is professional instead of median.

- **Studio** — guided intent + aesthetic lock before generation
- **Scan** — critical checklist auditor (evidence → user cost → smallest durable fix)
- **Skill** — `web-excellence` for any Grok / agent so the same rules apply everywhere
- **Self-applying** — this site is built with the rules it teaches

---

## Quick local view

```bash
cd aether
python3 -m http.server 8080
# open http://localhost:8080
```

Pages: `/` · `/studio.html` · `/scan.html` · `/standards.html`

---

## Perfect GitHub + Vercel setup (do this once)

### 1. Create the GitHub repository

```bash
# From the aether folder (this directory)
git remote add origin https://github.com/YOUR_USERNAME/aether.git   # create empty repo first on GitHub
git branch -M main
git push -u origin main
```

Recommended GitHub settings:
- Public (or private if preferred)
- Description: “Professional harness for AI web development — anti-slop, WCAG 2.2, guided Studio + critical Scan”
- Enable Issues
- Default branch: `main`
- Topics: `web-excellence`, `accessibility`, `wcag`, `anti-slop`, `ai`, `design-system`

### 2. Deploy to Vercel

1. Go to https://vercel.com → Add New Project
2. Import the GitHub repository `aether`
3. Framework Preset: **Other**
4. Root Directory: `.`
5. Build Command: leave empty
6. Output Directory: leave empty
7. Click **Deploy**

You receive a production URL such as `https://aether-xxxx.vercel.app`.  
Every push to `main` auto-deploys.

### 3. Optional Vercel settings

- Add a custom domain under Domains
- Security + CSS cache headers are already in `vercel.json`
- Later (Phase 3): add `/api/scan` serverless function for real remote URL scanning

### 4. Install the skill for agents

```bash
cp -r skill/web-excellence ~/.grok/skills/
# or project-local: ./.grok/skills/web-excellence
```

Then tell any Grok agent: “use the web-excellence skill”.

---

## For AI teams (Hermes and successors)

**Start here:**

1. Read `HANDOVER.md` (complete context transfer)
2. Read `ROADMAP.md` (ordered priorities)
3. Read `AGENTS.md` (rules you must follow)
4. Load `skill/web-excellence/`

Do not recreate the project. Continue from the current state.  
Update the “Last agent notes” section in HANDOVER.md when you finish a session.

---

## Project structure

```
aether/
├── index.html studio.html scan.html standards.html
├── css/tokens.css  css/base.css
├── skill/web-excellence/          # the agent skill
├── .github/workflows/check.yml    # basic excellence CI
├── vercel.json  package.json  LICENSE
├── HANDOVER.md   ROADMAP.md   AGENTS.md
└── README.md
```

---

## Continuous improvement cycle

1. Observe real usage / new standards / new slop patterns
2. Audit with Aether Scan or the Master Checklist
3. Make the smallest durable fix (prefer tokens)
4. Expand only according to ROADMAP priority
5. Self-apply — new code must itself pass the checklist
6. Commit with an excellence-focused message
7. Update HANDOVER.md notes + ROADMAP checkboxes
8. Repeat

---

## License

MIT. Use it, improve it, keep the constraints strong.
