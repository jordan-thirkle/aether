#!/usr/bin/env bash
# aether-push-gate.sh
# Git pre-push hook — enforces the AETHER MASTER STANDARD before any push.
# Install: cp aether-push-gate.sh .git/hooks/pre-push && chmod +x .git/hooks/pre-push
# Or: ln -sf ../../aether-push-gate.sh .git/hooks/pre-push

set -uo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PASS=0
FAIL=0
WARN=0

check() {
  local label="$1"
  local result="$2"  # pass, fail, or warn
  local detail="${3:-}"
  if [ "$result" = "pass" ]; then
    echo -e "  ${GREEN}✓${NC} $label"
    PASS=$((PASS + 1))
  elif [ "$result" = "warn" ]; then
    echo -e "  ${YELLOW}⚠${NC} $label — $detail"
    WARN=$((WARN + 1))
  else
    echo -e "  ${RED}✗${NC} $label — $detail"
    FAIL=$((FAIL + 1))
  fi
}

echo ""
echo "═══════════════════════════════════════════════"
echo "  AETHER PUSH GATE — Master Standard Check"
echo "═══════════════════════════════════════════════"
echo ""

# ─── 1. HTML VALIDATION ───
echo "1. HTML Structure"

# One h1 per file
for f in *.html; do
  [ -f "$f" ] || continue
  count=$(grep -c '<h1' "$f" 2>/dev/null || echo "0")
  if [ "$count" -eq 1 ]; then
    check "$f: exactly one h1" pass
  elif [ "$count" -eq 0 ]; then
    check "$f: missing h1" fail "Add exactly one <h1> per page"
  else
    check "$f: multiple h1s ($count)" fail "Reduce to exactly one <h1>"
  fi
done

# Skip link
for f in *.html; do
  [ -f "$f" ] || continue
  if grep -q 'skip-link\|Skip to main' "$f" 2>/dev/null; then
    check "$f: skip link present" pass
  else
    check "$f: missing skip link" fail "Add <a class=\"skip-link\" href=\"#main\">Skip to main content</a>"
  fi
done

# lang attribute
for f in *.html; do
  [ -f "$f" ] || continue
  if grep -q '<html lang=' "$f" 2>/dev/null; then
    check "$f: lang attribute" pass
  else
    check "$f: missing lang attribute" fail "Add lang attribute to <html>"
  fi
done

# viewport meta
for f in *.html; do
  [ -f "$f" ] || continue
  if grep -q 'viewport.*width=device-width' "$f" 2>/dev/null; then
    check "$f: viewport meta" pass
  else
    check "$f: missing viewport meta" fail "Add <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
  fi
done

# title
for f in *.html; do
  [ -f "$f" ] || continue
  if grep -q '<title>' "$f" 2>/dev/null; then
    title=$(grep -o '<title>[^<]*</title>' "$f" | sed 's/<[^>]*>//g')
    len=${#title}
    if [ "$len" -ge 10 ]; then
      check "$f: title present ($len chars)" pass
    else
      check "$f: title too short ($len chars)" warn "Title should be 10+ chars"
    fi
  else
    check "$f: missing title" fail "Add <title> element"
  fi
done

# meta description
for f in *.html; do
  [ -f "$f" ] || continue
  if grep -q 'meta name="description"' "$f" 2>/dev/null; then
    check "$f: meta description present" pass
  else
    check "$f: missing meta description" fail "Add <meta name=\"description\" content=\"...\">"
  fi
done

# Landmarks
for f in *.html; do
  [ -f "$f" ] || continue
  has_header=$(grep -c '<header' "$f" 2>/dev/null || echo "0")
  has_nav=$(grep -c '<nav' "$f" 2>/dev/null || echo "0")
  has_main=$(grep -c '<main' "$f" 2>/dev/null || echo "0")
  has_footer=$(grep -c '<footer' "$f" 2>/dev/null || echo "0")
  if [ "$has_header" -ge 1 ] && [ "$has_nav" -ge 1 ] && [ "$has_main" -ge 1 ]; then
    check "$f: landmarks (header, nav, main)" pass
  else
    check "$f: missing landmarks" fail "Add <header>, <nav>, <main> elements"
  fi
done

echo ""

# ─── 2. ANTI-SLOP ───
echo "2. Anti-Slop"

# No lorem ipsum — only flag in actual content, not rule descriptions
for f in *.html; do
  [ -f "$f" ] || continue
  real_content=$(grep -vi 'forbidden\|no lorem\|rules\|standard\|check\|must not\|should not\|never\|refuse\|constrain\|is not a direction' "$f" 2>/dev/null || true)
  if echo "$real_content" | grep -qi 'lorem ipsum' 2>/dev/null; then
    check "$f: lorem ipsum detected" fail "Replace placeholder content with real content"
  else
    check "$f: no lorem ipsum" pass
  fi
done

# No forbidden aesthetic phrases — only in actual content, not rule descriptions
for f in *.html; do
  [ -f "$f" ] || continue
  flagged=$(grep -i 'clean and modern\|sleek and modern\|cutting.edge' "$f" 2>/dev/null | grep -vi 'forbidden\|never\|rules\|standard\|not.*direction\|refuse\|constrain\|is not a direction\|not allowed\|forbidden' || true)
  if [ -n "$flagged" ]; then
    check "$f: forbidden aesthetic phrase" fail "Remove 'clean and modern' — name a specific aesthetic instead"
  else
    check "$f: no forbidden phrases" pass
  fi
done

echo ""

# ─── 3. CSS TOKENS ───
echo "3. CSS Architecture"

if [ -f "css/tokens.css" ]; then
  check "tokens.css exists" pass

  # Check for hardcoded hex in HTML (not in style attributes for aether's own pages)
  for f in *.html; do
    [ -f "$f" ] || continue
    # Count inline style hex colors (excluding known acceptable patterns)
    hardcoded=$(grep 'style=' "$f" 2>/dev/null | grep -oE '#[0-9a-fA-F]{3,8}' | grep -v 'var(' | wc -l)
    hardcoded=$(echo "$hardcoded" | tr -d '[:space:]')
    if [ "$hardcoded" -gt 2 ]; then
      check "$f: hardcoded hex in inline styles ($hardcoded)" warn "Use design tokens via var() instead"
    else
      check "$f: inline style hex ($hardcoded)" pass
    fi
  done
else
  check "tokens.css missing" fail "Create css/tokens.css with design tokens"
fi

echo ""

# ─── 4. ACCESSIBILITY ───
echo "4. Accessibility"

# Images with alt text
for f in *.html; do
  [ -f "$f" ] || continue
  imgs=$(grep -c '<img' "$f" 2>/dev/null || echo "0")
  imgs=$(echo "$imgs" | tr -d '[:space:]')
  if [ "$imgs" -gt 0 ]; then
    imgs_with_alt=$(grep -c '<img[^>]*alt=' "$f" 2>/dev/null || echo "0")
    imgs_with_alt=$(echo "$imgs_with_alt" | tr -d '[:space:]')
    if [ "$imgs_with_alt" -ge 1 ]; then
      check "$f: images have alt text" pass
    else
      check "$f: images missing alt text" fail "Add alt attributes to all <img> elements"
    fi
  fi
done

# Form labels
for f in *.html; do
  [ -f "$f" ] || continue
  inputs=$(grep -c '<input\|<select\|<textarea' "$f" 2>/dev/null || echo "0")
  inputs=$(echo "$inputs" | tr -d '[:space:]')
  if [ "$inputs" -gt 0 ]; then
    labels=$(grep -c '<label' "$f" 2>/dev/null || echo "0")
    labels=$(echo "$labels" | tr -d '[:space:]')
    if [ "$labels" -ge "$inputs" ]; then
      check "$f: form labels present" pass
    else
      check "$f: forms may lack labels" warn "Ensure all inputs have associated <label> or aria-label"
    fi
  fi
done

echo ""

# ─── 5. BUILD ───
echo "5. Build"

# package.json exists
if [ -f "package.json" ]; then
  check "package.json present" pass

  # npm audit (non-blocking)
  if command -v npm &>/dev/null; then
    audit_out=$(npm audit --production 2>&1 || true)
    if echo "$audit_out" | grep -q "0 vulnerabilities"; then
      check "npm audit: clean" pass
    elif echo "$audit_out" | grep -q "found 0 vulnerabilities"; then
      check "npm audit: clean" pass
    else
      vulns=$(echo "$audit_out" | grep -oP '\d+ vulnerabilit' | head -1 || echo "unknown")
      check "npm audit: $vulns" warn "Run npm audit fix"
    fi
  fi
else
  check "No package.json (static site)" pass
fi

# No node_modules in git
if [ -d ".git" ]; then
  tracked_nm=$(git ls-files node_modules 2>/dev/null | wc -l || echo "0")
  if [ "$tracked_nm" -gt 0 ]; then
    check "node_modules tracked in git" fail "Add node_modules to .gitignore"
  else
    check "node_modules not tracked" pass
  fi
fi

echo ""

# ─── 6. SECRETS ───
echo "6. Security"

# No API keys in tracked files
if [ -d ".git" ]; then
  secrets=$(git grep -l 'sk-\|AIza\|ghp_\|gho_\|Bearer [A-Za-z0-9]' -- ':!*.md' ':!*.log' ':!.git/hooks/*' ':!aether-push-gate.sh' 2>/dev/null || true)
  if [ -n "$secrets" ]; then
    check "Potential secrets in tracked files" fail "Found in: $secrets — remove and add to .gitignore"
  else
    check "No secrets in tracked files" pass
  fi
fi

# .env not tracked
if [ -d ".git" ]; then
  tracked_env=$(git ls-files .env .env.* 2>/dev/null | wc -l || echo "0")
  if [ "$tracked_env" -gt 0 ]; then
    check ".env files tracked" fail "Add .env* to .gitignore"
  else
    check ".env files not tracked" pass
  fi
fi

echo ""

# ─── SUMMARY ───
echo "═══════════════════════════════════════════════"
TOTAL=$((PASS + FAIL + WARN))
echo -e "  ${GREEN}$PASS passed${NC}  ${YELLOW}$WARN warnings${NC}  ${RED}$FAIL failed${NC}  ($TOTAL total)"
echo "═══════════════════════════════════════════════"

if [ "$FAIL" -gt 0 ]; then
  echo ""
  echo -e "${RED}PUSH BLOCKED${NC} — $FAIL gate(s) failed."
  echo "Fix the issues above, then try again."
  echo ""
  exit 1
else
  echo ""
  echo -e "${GREEN}PUSH APPROVED${NC} — All gates passed."
  echo ""
  exit 0
fi
