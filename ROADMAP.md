# Aether Roadmap

Priority is quality and constraint, not feature count.

## Phase 0 — Foundation (DONE)

- [x] Design tokens (oklch, light/dark, fluid type/space)
- [x] Base styles + accessible components
- [x] Landing page (anti-slop positioning)
- [x] Studio Step 1 — intent + aesthetic lock
- [x] Aether Scan (client-side critical checklist)
- [x] Standards summary page
- [x] web-excellence skill + Master Checklist
- [x] Local git baseline
- [x] Complete handover package

## Phase 1 — Make it real & public (next)

1. Push repository to GitHub (see README “GitHub + Vercel setup”).
2. Connect to Vercel → automatic production URL.
3. Add simple custom domain later if desired.
4. Confirm every page still passes self-scan after deploy.
5. Add a public “Copy skill” / installation note so other agents can use `web-excellence`.

## Phase 2 — Stronger Studio

- Step 2: Token generator (palette, type scale, radius, motion) locked to chosen aesthetic.
- Step 3: Information architecture / page list with required states.
- Step 4: Constrained generation prompt export (ready for any coding agent).
- Persist project state (localStorage first, then optional backend).

## Phase 3 — Real scanner power

- Vercel serverless function:
  - Accept URL
  - Fetch with Playwright (or equivalent)
  - Run axe-core + selected Lighthouse audits
  - Apply Aether anti-slop heuristics
  - Return the same critical report format (evidence → user cost → smallest fix)
- Keep client-side paste mode as the offline / privacy path.
- Optional: save scan history against a project.

## Phase 4 — Continuous excellence loop

- Automated checklist regression on every PR (GitHub Action).
- Living “slop patterns” library that is updated when new AI defaults appear.
- Self-audit badge / score that the site itself displays (honest, not vanity).
- Skill versioning that stays in sync with product changes.

## Phase 5 — Optional product surfaces (only if still excellent)

- Project dashboard (multiple sites)
- Export to starter kit (HTML/CSS or framework of choice) that already obeys the locked system
- Team / org mode
- Marketplace of vetted aesthetic directions (still constrained)

## Explicit non-goals (until strong reason)

- Becoming another generic website builder
- Supporting every framework equally at the expense of quality
- Soft, encouraging scores that hide real problems
- Decorative motion or visual trends that fight accessibility or performance

## Success metric

A site created end-to-end through Aether should require almost no manual accessibility or hierarchy repair, and should not look like the current median AI landing page.
