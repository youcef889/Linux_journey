#!/usr/bin/env bash
#
# fix-hugo-theme.sh
# Diagnoses and patches the "error calling partial head.html" failure
# in a Hugo site using the Blowfish theme (e.g. Linux_journey).
#
# Usage:
#   ./fix-hugo-theme.sh            # diagnose only
#   ./fix-hugo-theme.sh --fix      # diagnose AND attempt repair
#
set -euo pipefail

REPO_ROOT="$(git rev-parse --show-toplevel 2>/dev/null || pwd)"
THEME_DIR="${REPO_ROOT}/themes/blowfish"
HEAD_PARTIAL="${THEME_DIR}/layouts/partials/head.html"
FIX_MODE=false
[[ "${1:-}" == "--fix" ]] && FIX_MODE=true

log()  { printf '\033[1;36m[*]\033[0m %s\n' "$1"; }
ok()   { printf '\033[1;32m[OK]\033[0m %s\n' "$1"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$1"; }
err()  { printf '\033[1;31m[FAIL]\033[0m %s\n' "$1"; }

cd "$REPO_ROOT"
log "Repo root: $REPO_ROOT"

# ---------------------------------------------------------------------------
# 1. Check submodule is initialized and not empty
# ---------------------------------------------------------------------------
log "Checking theme submodule status..."
if [[ ! -d "$THEME_DIR" ]] || [[ -z "$(ls -A "$THEME_DIR" 2>/dev/null)" ]]; then
    err "Theme directory missing or empty: $THEME_DIR"
    if $FIX_MODE; then
        log "Initializing/updating submodules..."
        git submodule update --init --recursive
    else
        warn "Run with --fix to run: git submodule update --init --recursive"
    fi
else
    ok "Theme directory present and non-empty."
fi

git submodule status || true

# ---------------------------------------------------------------------------
# 2. Check head.html exists
# ---------------------------------------------------------------------------
log "Checking for head.html partial..."
if [[ ! -f "$HEAD_PARTIAL" ]]; then
    err "head.html not found at $HEAD_PARTIAL"
    if $FIX_MODE; then
        log "Attempting to re-checkout submodule at recorded commit..."
        git submodule deinit -f themes/blowfish || true
        rm -rf "$THEME_DIR"
        git submodule update --init --recursive --force themes/blowfish
        if [[ -f "$HEAD_PARTIAL" ]]; then
            ok "head.html restored after submodule re-checkout."
        else
            err "Still missing. The theme commit pinned in .gitmodules/git may be broken."
            warn "Consider pointing the submodule at a known-good tag, e.g.:"
            echo "    cd themes/blowfish && git fetch --tags && git checkout v2.74.0 && cd -"
            echo "    git add themes/blowfish && git commit -m 'pin blowfish theme to v2.74.0'"
        fi
    fi
else
    ok "head.html found."
fi

# ---------------------------------------------------------------------------
# 3. Basic Go-template sanity check on head.html (and files it includes)
# ---------------------------------------------------------------------------
check_template_balance() {
    local file="$1"
    local opens closes
    opens=$(grep -o '{{' "$file" 2>/dev/null | wc -l)
    closes=$(grep -o '}}' "$file" 2>/dev/null | wc -l)
    if [[ "$opens" != "$closes" ]]; then
        err "Unbalanced {{ }} in $file  (opens=$opens closes=$closes)"
        return 1
    fi
    return 0
}

if [[ -f "$HEAD_PARTIAL" ]]; then
    log "Checking template brace balance in head.html..."
    if check_template_balance "$HEAD_PARTIAL"; then
        ok "head.html braces balanced."
    fi

    log "Scanning partials referenced from head.html for the same issue..."
    grep -oE 'partial(Cached)? "[^"]+"' "$HEAD_PARTIAL" 2>/dev/null | \
        sed -E 's/partial(Cached)? "([^"]+)"/\2/' | sort -u | while read -r p; do
        candidate="${THEME_DIR}/layouts/partials/${p}"
        [[ -f "$candidate" ]] || candidate="${REPO_ROOT}/layouts/partials/${p}"
        if [[ -f "$candidate" ]]; then
            check_template_balance "$candidate" && ok "  $p OK"
        else
            warn "  Referenced partial not found: $p (checked theme + site layouts/partials)"
        fi
    done
fi

# ---------------------------------------------------------------------------
# 4. Check Hugo binary version vs theme's required version
# ---------------------------------------------------------------------------
log "Checking Hugo version..."
if command -v hugo >/dev/null 2>&1; then
    HUGO_VERSION_STR="$(hugo version)"
    echo "  $HUGO_VERSION_STR"
    if ! echo "$HUGO_VERSION_STR" | grep -qi 'extended'; then
        err "Hugo binary is NOT the 'extended' edition."
        warn "Blowfish requires the extended edition (for SCSS/Sass pipes)."
        warn "Void Linux: check 'xbps-query -Rs hugo' for an extended package,"
        warn "or download the *_extended_* binary from:"
        warn "  https://github.com/gohugoio/hugo/releases"
    else
        ok "Extended edition detected."
    fi

    if [[ -f "${THEME_DIR}/theme.toml" ]]; then
        MIN_VER=$(grep -i 'min_version' "${THEME_DIR}/theme.toml" 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' || true)
        [[ -n "$MIN_VER" ]] && echo "  Theme declares min_version: $MIN_VER (compare against your hugo version above)"
    fi
else
    err "hugo binary not found in PATH."
fi

# ---------------------------------------------------------------------------
# 5. Optional: attempt an actual local build to confirm
# ---------------------------------------------------------------------------
if $FIX_MODE; then
    log "Attempting local build (hugo --gc --minify --printPathWarnings)..."
    if hugo --gc --minify --printPathWarnings; then
        ok "Build succeeded."
    else
        err "Build still failing. See output above for the updated error."
        warn "If error persists at baseof.html:8 -> head.html, capture:"
        warn "  hugo --logLevel debug 2>&1 | tee hugo-debug.log"
        warn "and inspect hugo-debug.log around the 'executing head.html' line."
    fi
else
    warn "Diagnostics complete. Re-run with --fix to attempt repair + local build."
fi
