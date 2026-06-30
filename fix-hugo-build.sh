#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "$0")" && pwd)"
cd "$ROOT"

echo "=== Step 1: Check theme ==="
if [ -d "themes/blowfish" ]; then
  echo "  Theme 'blowfish' found."
else
  echo "  ERROR: Theme 'blowfish' missing. Clone it:"
  echo "    git clone https://github.com/nunocoracao/blowfish.git themes/blowfish"
  exit 1
fi

echo ""
echo "=== Step 2: Fix config deprecation warnings ==="
# Hugo >=0.158 deprecated languageCode -> locale, languageName -> label
LANG_FILE="config/_default/languages.en.toml"
if grep -q '^languageCode' "$LANG_FILE"; then
  sed -i 's/^languageCode = "\(.*\)"/locale = "\1"/' "$LANG_FILE"
  echo "  Fixed: languageCode -> locale"
fi
if grep -q '^languageName' "$LANG_FILE"; then
  sed -i 's/^languageName = "\(.*\)"/label = "\1"/' "$LANG_FILE"
  echo "  Fixed: languageName -> label"
fi

echo ""
echo "=== Step 3: Verify baseof.html ==="
if [ -f "themes/blowfish/layouts/_default/baseof.html" ]; then
  echo "  baseof.html found in theme."
else
  echo "  ERROR: baseof.html missing in theme!"
  exit 1
fi

echo ""
echo "=== Step 4: Clear Hugo cache ==="
if [ -d "resources/_gen" ]; then
  rm -rf resources/_gen
  echo "  Cleared resources/_gen/"
else
  echo "  Nothing to clear."
fi

echo ""
echo "=== Step 5: Verify directory structure ==="
for dir in content layouts static config themes/blowfish; do
  if [ -d "$dir" ]; then
    echo "  OK: $dir"
  else
    echo "  WARNING: $dir missing"
  fi
done

echo ""
echo "=== Step 6: Test Hugo build ==="
echo "  Running: hugo --gc --minify"
if hugo --gc --minify 2>&1; then
  echo "  Build succeeded!"
else
  echo "  Build failed. Check the output above."
  exit 1
fi

echo ""
echo "=== All steps completed successfully ==="
