---
name: web-excellence
description: Apply 2026 web excellence standards including WCAG 2.2 AA, anti-AI-slop rules, Core Web Vitals, Nielsen heuristics, modern CSS, semantic HTML, OWASP awareness, SEO and i18n on every website, UI, frontend, component or redesign task. Triggers on web design, website build, UI/UX, accessibility, a11y, responsive, frontend, performance, or related prompts. Forces intentional design decisions and rejects generic AI defaults.
---

# Web Excellence

Enforce production-grade, anti-slop web standards on every design and development task.

## Process (mandatory)

1. Lock intent, audience and one clear aesthetic direction before generating UI. “Clean and modern” is not a direction — it is the default that produces slop.
2. Apply the Master Checklist in references/checklist.md as the gate. Do not ship incomplete items.
3. Prefer progressive enhancement, semantic native HTML, ARIA only when necessary.
4. Mobile-first. Use Grid + Flex + container queries. Fluid type/spacing with clamp. Logical properties.
5. Reject purple/indigo gradients, glassmorphism+neon, identical three-card grids, decorative motion, missing states, weak hierarchy.
6. Output must include a short Excellence Compliance note.

## Non-negotiables

- WCAG 2.2 AA (Focus Not Obscured, Target Size ≥24×24, Accessible Authentication, etc.)
- Core Web Vitals: LCP ≤2.5s, INP ≤200ms, CLS <0.1
- Nielsen 10 heuristics + loading/empty/error/success states
- Design tokens, strong hierarchy, restrained palette
- Semantic HTML, visible focus, keyboard complete, reduced-motion

Load references/checklist.md before substantial generation.
Living product is this repository.
