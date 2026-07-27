# Master Web Excellence Checklist (2026)

Every applicable item must pass before output.

## Accessibility (WCAG 2.2 AA)
- Semantic HTML5, one h1, logical heading order, landmarks
- Keyboard operable, visible focus never fully obscured
- Target size ≥ 24×24 CSS px (prefer 44×44 for primary)
- Contrast ≥ 4.5:1 text / 3:1 UI · color not sole cue
- Forms have associated labels + clear error recovery
- Accessible authentication (no pure cognitive tests)
- prefers-reduced-motion respected · lang attribute · skip link

## Anti-slop
- One locked aesthetic direction (not “clean and modern”)
- No default purple/indigo gradients, glassmorphism+neon, identical three-card icon grids
- Strong hierarchy (squint test) · real content · all four states designed
- Design tokens for color, type, space, radius, motion

## UX (Nielsen + HIG)
- System status visible · real-world language · undo/escape
- Consistency · error prevention · recognition over recall
- Loading / empty / error / success states present
- Purpose clear · user has agency · craft details

## Performance
- LCP ≤ 2.5s · INP ≤ 200ms · CLS < 0.1
- Images sized + modern formats · fonts controlled · minimal main-thread work

## Layout / CSS
- Mobile-first · Grid (2D) + Flex (1D) · container queries for components
- Fluid clamp() type/spacing · logical properties · cascade-friendly

## Security / SEO / i18n
- No client-only auth · sanitize mindset · CSP-friendly
- Unique titles/descriptions · semantic structure · structured data where valuable
- lang + logical properties for RTL readiness

Done = all applicable boxes checked + short compliance note.
