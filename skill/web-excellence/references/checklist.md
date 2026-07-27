# AETHER MASTER STANDARD

**Version:** 1.0 — 2026-07-27  
**Status:** Living standard. Every applicable item must pass before output.  
**Scope:** Every website, web app, UI component, frontend task, or redesign.

---

## How to use this standard

1. **Before building:** Lock aesthetic direction. Read Section 1 (Anti-Slop) first.
2. **During building:** Reference each section as you work. Check items off mentally.
3. **Before shipping:** Run the full gate. Every applicable item must pass.
4. **After shipping:** Monitor, iterate, repeat.

### Automation legend

- **🔧 Browser** — Can be checked in-browser with JS/DOM inspection
- **🔧 Vercel** — Can be enforced via Vercel config, headers, or build checks
- **🔧 CI** — Can be automated in a CI pipeline (GitHub Actions, etc.)
- **👁️ Human** — Requires human judgment or external tools
- **🌐 External** — Requires external service (Lighthouse, axe-core, etc.)

---

## 1. Anti-Slop (ENFORCED FIRST)

**If this section fails, nothing else matters.** Anti-slop is not a preference — it is a quality gate.

### 1.1 Aesthetic Direction Lock

| Item | Automation | Check |
|------|-----------|-------|
| One explicit aesthetic direction named and documented before any UI generation | 👁️ Human | Does the project have a written aesthetic direction? |
| "Clean and modern" is never used as an aesthetic direction | 🔧 Browser | Search generated output for forbidden phrases |
| Aesthetic direction is specific: named palette, type personality, motion character, mood | 👁️ Human | Is the direction specific enough to constrain decisions? |

### 1.2 Forbidden Patterns

| Item | Automation | Check |
|------|-----------|-------|
| No default purple/indigo gradients as primary visual device | 🔧 Browser | DOM scan for purple/indigo gradient usage |
| No glassmorphism + neon as primary visual device | 👁️ Human | Visual inspection — frosted glass + glow effects |
| No identical three-card feature grids with icons | 🔧 Browser | DOM scan for repeated 3-column card patterns |
| No missing interaction states (hover, focus, active, disabled, loading) | 🔧 Browser | Check all interactive elements for state styles |
| No lorem ipsum or placeholder content in production | 🔧 Browser | Search DOM for "lorem ipsum", "placeholder" |
| No decorative motion that fights accessibility | 👁️ Human | Does animation serve function or just decoration? |

### 1.3 Hierarchy & Content

| Item | Automation | Check |
|------|-----------|-------|
| Strong visual hierarchy passes squint test | 👁️ Human | Squint at the page — is the primary element obvious? |
| Real content, not generic copy | 👁️ Human | Is the content specific to this project? |
| All four states designed: loading, empty, error, success | 🔧 Browser | Do loading/empty/error/success states exist in code? |
| Design tokens used for color, type, space, radius, motion | 🔧 Browser | Are values referenced from token variables, not hardcoded? |

---

## 2. Accessibility (WCAG 2.2 AA)

**The floor, not the ceiling.** Every item here is a legal and ethical requirement.

### 2.1 Structure & Semantics

| Item | Automation | WCAG | Check |
|------|-----------|------|-------|
| Valid HTML5, one `<h1>`, logical heading order | 🔧 Browser | 1.3.1 | DOM scan: one h1, h2→h3→h4 in order |
| Landmark regions: `<header>`, `<nav>`, `<main>`, `<footer>` | 🔧 Browser | 1.3.1 | Check for landmark elements |
| `<html lang="en">` (or appropriate language) | 🔧 Browser | 3.1.1 | Check lang attribute |
| `<title>` is unique and descriptive per page | 🔧 Browser | 2.4.2 | Check title element |
| Skip link present and functional | 🔧 Browser | 2.4.1 | Check for skip link, verify it targets main |
| Viewport meta: `width=device-width, initial-scale=1` | 🔧 Browser | — | Check viewport meta tag |
| Color scheme declared (`color-scheme: light dark`) | 🔧 Browser | — | Check meta or CSS |

### 2.2 Keyboard & Focus

| Item | Automation | WCAG | Check |
|------|-----------|------|-------|
| All interactive elements keyboard operable | 🔧 Browser | 2.1.1 | Tab through entire page — every button/link/input reachable |
| Visible focus indicator never fully obscured | 🔧 Browser | 2.4.7 | Tab through — focus ring visible on every element |
| Focus order follows logical document order | 👁️ Human | 2.4.3 | Does tab order make sense? |
| No keyboard traps | 🔧 Browser | 2.1.2 | Tab through — can you always escape every component? |
| Focus management in SPAs (focus moves to new content) | 👁️ Human | 2.4.3 | After navigation, does focus move to the new heading/content? |
| Target size ≥ 24×24 CSS px (prefer 44×44 for primary) | 🔧 Browser | 2.5.8 | Measure all interactive elements |

### 2.3 Color & Contrast

| Item | Automation | WCAG | Check |
|------|-----------|------|-------|
| Text contrast ≥ 4.5:1 (normal text) | 🔧 Browser | 1.4.3 | Compute contrast ratios for all text/background pairs |
| Large text contrast ≥ 3:1 (≥18pt or ≥14pt bold) | 🔧 Browser | 1.4.3 | Same check, adjusted thresholds |
| UI component contrast ≥ 3:1 (borders, icons, focus rings) | 🔧 Browser | 1.4.11 | Check interactive element borders |
| Color is not the sole cue for information | 👁️ Human | 1.4.1 | Are errors indicated by more than just red? |
| `prefers-reduced-motion` respected | 🔧 Browser | 2.3.3 | Check CSS for `prefers-reduced-motion` media query |

### 2.4 Forms & Authentication

| Item | Automation | WCAG | Check |
|------|-----------|------|-------|
| All inputs have associated `<label>` elements | 🔧 Browser | 1.3.1 | Check every `<input>`, `<select>`, `<textarea>` has a label |
| Error messages are specific and suggest correction | 👁️ Human | 3.3.1 | Are error messages helpful, not just "invalid"? |
| Error recovery is clear (what to do next) | 👁️ Human | 3.3.1 | Can the user fix the error without starting over? |
| No pure cognitive tests for authentication | 👁️ Human | 2.2.1 | Is there a non-cognitive alternative? |
| Required fields indicated programmatically | 🔧 Browser | 3.3.2 | Check for `required` or `aria-required` |

### 2.5 Screen Reader & Assistive Tech

| Item | Automation | WCAG | Check |
|------|-----------|------|-------|
| Images have meaningful `alt` text (or `alt=""` for decorative) | 🔧 Browser | 1.1.1 | Check all `<img>` for alt attributes |
| Form inputs have accessible names | 🔧 Browser | 4.1.2 | Check label/aria-label associations |
| Interactive elements have accessible names | 🔧 Browser | 4.1.2 | Check button/link text content |
| ARIA used only when HTML semantics are insufficient | 👁️ Human | 4.1.2 | Is ARIA adding meaning or just noise? |
| Dynamic content announces changes (aria-live, role="alert") | 👁️ Human | 4.1.3 | Do status updates reach screen readers? |

---

## 3. Performance (Core Web Vitals)

**Measurable, not aspirational.** Every number has a threshold.

### 3.1 Core Web Vitals

| Item | Automation | Threshold | Check |
|------|-----------|-----------|-------|
| LCP (Largest Contentful Paint) | 🌐 Lighthouse | ≤ 2.5s | Run Lighthouse, check LCP |
| INP (Interaction to Next Paint) | 🌐 Lighthouse | ≤ 200ms | Run Lighthouse, check INP |
| CLS (Cumulative Layout Shift) | 🌐 Lighthouse | < 0.1 | Run Lighthouse, check CLS |

### 3.2 Assets & Loading

| Item | Automation | Check |
|------|-----------|-------|
| Images sized appropriately (no oversized downloads) | 🔧 Browser | Check `width`/`height` attributes, natural vs displayed size |
| Modern image formats (WebP, AVIF) where supported | 🔧 Vercel | Vercel automatically serves WebP/AVIF |
| Images lazy-loaded below the fold | 🔧 Browser | Check `loading="lazy"` on below-fold images |
| Font loading controlled (swap, display, preload) | 🔧 Browser | Check `font-display` in @font-face |
| Minimal main-thread work (< 50ms per frame) | 🌐 Lighthouse | Run Lighthouse, check TBT |

### 3.3 Network & Caching

| Item | Automation | Check |
|------|-----------|-------|
| Static assets cached (Cache-Control headers) | 🔧 Vercel | Check Vercel headers config |
| Critical CSS inlined, rest deferred | 👁️ Human | Is above-fold content styled without external CSS? |
| JavaScript non-blocking (async/defer) | 🔧 Browser | Check script loading strategy |

---

## 4. UX (Nielsen Heuristics + Apple HIG)

**Human judgment required.** These items test whether the interface *works*, not just whether it *looks right*.

### 4.1 Nielsen's 10 Heuristics

| Item | Automation | Check |
|------|-----------|-------|
| System status visible (loading, progress, completion) | 🔧 Browser | Do loading states exist? |
| Real-world language (no jargon, no techspeak) | 👁️ Human | Would a non-technical user understand the copy? |
| User has agency (undo, escape, cancel available) | 👁️ Human | Can the user reverse or exit every action? |
| Consistency (same patterns, same labels, same behavior) | 👁️ Human | Are similar things treated similarly? |
| Error prevention (constraining bad input before it happens) | 👁️ Human | Are there guards against mistakes? |
| Recognition over recall (visible options, not memorized) | 👁️ Human | Are navigation and actions visible, not hidden? |
| Flexibility (keyboard shortcuts, customization) | 👁️ Human | Does the interface adapt to different users? |
| Aesthetic/minimalist design (only essential info) | 👁️ Human | Is there anything unnecessary? |
| Help users recognize/recover from errors | 👁️ Human | Are error messages specific and helpful? |
| Help and documentation (if needed, easy to find) | 👁️ Human | Is help available without leaving the flow? |

### 4.2 Interaction States

| Item | Automation | Check |
|------|-----------|-------|
| Loading state designed and implemented | 🔧 Browser | Check for skeleton/spinner/loading patterns |
| Empty state designed and implemented | 🔧 Browser | Check for empty/null state handling |
| Error state designed and implemented | 🔧 Browser | Check for error state UI |
| Success state designed and implemented | 🔧 Browser | Check for success confirmation UI |
| Hover state on all interactive elements | 🔧 Browser | Check `:hover` styles |
| Active/pressed state on buttons | 🔧 Browser | Check `:active` styles |
| Disabled state styled distinctly | 🔧 Browser | Check `[disabled]` styles |

---

## 5. Layout & CSS

**Technical correctness.** These items ensure the code is maintainable and responsive.

### 5.1 Responsive Design

| Item | Automation | Check |
|------|-----------|-------|
| Mobile-first: base styles for mobile, `min-width` for larger | 🔧 Browser | Check media query direction |
| No horizontal scroll at any viewport width | 🔧 Browser | Test at 320px, 375px, 768px, 1024px, 1440px |
| Touch targets ≥ 44×44 on mobile | 🔧 Browser | Measure tap targets at mobile viewport |
| Content reflows at every breakpoint | 👁️ Human | Does text/content wrap naturally? |

### 5.2 CSS Architecture

| Item | Automation | Check |
|------|-----------|-------|
| Grid for 2D layouts, Flexbox for 1D | 🔧 Browser | Check layout method matches intent |
| Container queries for components (not just viewport) | 🔧 Browser | Check for `@container` usage |
| Fluid type/spacing with `clamp()` | 🔧 Browser | Check for clamp() in type/spacing |
| Logical properties (`margin-inline`, `padding-block`) | 🔧 Browser | Check for logical vs physical properties |
| Cascade-friendly (no excessive specificity) | 👁️ Human | Is the CSS maintainable? |
| Design tokens referenced, not hardcoded values | 🔧 Browser | Check for var() references |
| Dark mode supported via tokens | 🔧 Browser | Check `prefers-color-scheme` or token toggles |

---

## 6. Security

**Prevent common vulnerabilities.** Not a full security audit — a reasonable baseline.

### 6.1 Headers & Config

| Item | Automation | Check |
|------|-----------|-------|
| `X-Content-Type-Options: nosniff` | 🔧 Vercel | Check response headers |
| `X-Frame-Options: DENY` or `SAMEORIGIN` | 🔧 Vercel | Check response headers |
| `Referrer-Policy` set appropriately | 🔧 Vercel | Check response headers |
| `Permissions-Policy` restricts unnecessary APIs | 🔧 Vercel | Check response headers |
| CSP header (if feasible) | 🔧 Vercel | Check Content-Security-Policy |

### 6.2 Code & Data

| Item | Automation | Check |
|------|-----------|-------|
| No client-side secrets (API keys in JS) | 🔧 Browser | Search JS bundles for key patterns |
| Input sanitized before rendering | 👁️ Human | Is user input escaped before DOM insertion? |
| Dependencies audited (`npm audit`) | 🔧 CI | Run npm audit in CI |
| Auth is server-side (no pure client auth) | 👁️ Human | Is authentication handled on the server? |

---

## 7. SEO & Discoverability

**Help search engines understand and surface the content.**

### 7.1 On-Page SEO

| Item | Automation | Check |
|------|-----------|-------|
| Unique `<title>` per page (50-60 chars) | 🔧 Browser | Check title length and uniqueness |
| Unique `<meta name="description">` per page (120-160 chars) | 🔧 Browser | Check meta description presence and length |
| One `<h1>` per page, relevant to content | 🔧 Browser | Check h1 count and content |
| Semantic HTML structure (article, section, nav) | 🔧 Browser | Check landmark usage |
| Canonical URL set | 🔧 Browser | Check `<link rel="canonical">` |

### 7.2 Structured Data & Social

| Item | Automation | Check |
|------|-----------|-------|
| Open Graph tags (og:title, og:description, og:image) | 🔧 Browser | Check for OG meta tags |
| Twitter Card tags (twitter:card, title, description) | 🔧 Browser | Check for Twitter meta tags |
| Structured data (JSON-LD) where valuable | 👁️ Human | Is structured data appropriate for this content? |
| `robots.txt` present and correct | 🔧 Browser | Check for robots.txt |
| `sitemap.xml` present and current | 🔧 Browser | Check for sitemap.xml |

---

## 8. i18n & Internationalization

**Ready for global audiences.**

| Item | Automation | Check |
|------|-----------|-------|
| `lang` attribute on `<html>` | 🔧 Browser | Check lang value |
| Logical CSS properties (margin-inline, not margin-left) | 🔧 Browser | Search for physical properties |
| Content direction support (RTL readiness) | 🔧 Browser | Check `dir` attribute handling |
| Translation-ready strings (no hardcoded text in CSS) | 👁️ Human | Are text strings extractable? |
| Date/number formats locale-aware | 👁️ Human | Are formats configurable? |

---

## 9. Testing

**Honest about what can and cannot be automated.**

### 9.1 Automated (In-Browser / CI)

| Item | Tool | Check |
|------|------|-------|
| DOM-based accessibility checks | 🔧 Browser / axe-core | Run axe on every page |
| Lighthouse audit | 🌐 Lighthouse | Performance, accessibility, SEO scores |
| HTML validation | 🔧 CI | W3C validator |
| CSS validation | 🔧 CI | Stylelint |
| Link checking | 🔧 CI | Broken link detector |
| Image alt text coverage | 🔧 Browser | All images have alt |

### 9.2 Semi-Automated (Tool-Assisted)

| Item | Tool | Check |
|------|------|-------|
| Cross-browser testing | 🌐 BrowserStack / Sauce Labs | Test on Chrome, Firefox, Safari, Edge |
| Responsive testing | 🔧 Browser DevTools | Test at 320, 375, 768, 1024, 1440px |
| Visual regression | 🌐 Percy / Chromatic | Screenshot comparison across deploys |

### 9.3 Human Judgment Required

| Item | Check |
|------|-------|
| Screen reader testing (NVDA, VoiceOver, JAWS) | Manually navigate with screen reader |
| Keyboard-only navigation flow | Complete all tasks using only keyboard |
| Cognitive accessibility | Would a user with cognitive disabilities understand this? |
| Content quality | Is the copy accurate, helpful, and well-written? |
| Visual design quality | Does it look professional? Does the hierarchy work? |
| Error message helpfulness | Would the error message help a confused user? |
| Mobile real-world usability | Does it work on a real phone, held in a hand? |

---

## 10. Build & Deploy

**Ship with confidence.**

| Item | Automation | Check |
|------|-----------|-------|
| Semantic versioning | 🔧 CI | Check version in package.json |
| CI/CD pipeline (lint, test, build) | 🔧 GitHub Actions | Check for .github/workflows |
| Environment variables documented | 🔧 Vercel | Check .env.example |
| Domain + SSL configured | 🔧 Vercel | Check Vercel domain settings |
| Rollback capability | 🔧 Vercel | Can previous deploy be restored? |
| Build succeeds with zero errors | 🔧 CI | Check build output |

---

## 11. Monitor & Iterate

**The job isn't done at deploy.**

| Item | Automation | Check |
|------|-----------|-------|
| CWV tracking (real users) | 🌐 Vercel Analytics / web-vitals | Are CWV metrics being collected? |
| Error tracking | 🌐 Sentry / similar | Are runtime errors captured? |
| Analytics (privacy-first) | 🌐 Plausible / similar | Is usage data being collected ethically? |
| Content freshness | 👁️ Human | Is the content still accurate and current? |
| Dependency updates | 🔧 CI / Dependabot | Are deps being updated? |

---

## Gate: What "Done" Means

A task is complete when:

1. **Anti-slop gate passes** — No forbidden patterns, aesthetic direction locked
2. **All applicable items in Sections 2-11 pass** — Automated checks pass, human checks verified
3. **Aether itself remains compliant** — Changes don't break the product's own standards
4. **Documentation updated** — HANDOVER.md and ROADMAP.md reflect the change
5. **Commit message states the excellence impact** — "Add focus-visible to all interactive controls — WCAG 2.4.13"

If any item fails, the task is not done. Fix it or explicitly document why it's out of scope.

---

## Honesty Notes

**What this standard can enforce automatically:**
- DOM structure, heading order, landmarks, alt text, labels
- Contrast ratios, target sizes, focus visibility
- Meta tags, title uniqueness, canonical URLs
- CSS architecture, token usage, responsive breakpoints
- Build success, dependency auditing, header configuration

**What requires human judgment:**
- Whether the aesthetic direction is good
- Whether the content is actually helpful
- Whether error messages are clear to confused users
- Whether the visual design is professional
- Whether motion serves function
- Whether the experience works on a real phone in a real hand

**What requires external tools:**
- Real Lighthouse scores (not simulated)
- Cross-browser compatibility
- Screen reader behavior
- Visual regression detection
- Real-user CWV data

**What this standard deliberately does NOT do:**
- Score or grade (honest assessment, not vanity metrics)
- Replace human design judgment
- Guarantee accessibility (it makes failure expensive, not impossible)
- Cover backend, database, or API design (out of scope for v1)

---

*This is the AETHER MASTER STANDARD v1.0. It is the single source of truth for web excellence. Update it when the web platform evolves, not when trends change.*
