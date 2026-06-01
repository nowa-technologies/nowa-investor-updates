#!/usr/bin/env bash
#
# Publish a new month of investor-update assets to GitHub Pages.
#
# Usage:
#   ./publish-month.sh YYYY-MM /path/to/source-folder
#
# The source folder should contain at minimum:
#   hero.jpg, prototype.jpg, factory.jpg, mission.jpg, logo.png
# Optionally also:
#   index.html (the final rendered email)
#
# Example:
#   ./publish-month.sh 2026-06 ~/Desktop/june-images

set -euo pipefail

MONTH="${1:-}"
SRC="${2:-}"

if [[ -z "$MONTH" || -z "$SRC" ]]; then
  echo "Usage: $0 YYYY-MM /path/to/source-folder"
  echo ""
  echo "Source folder must contain: hero.jpg, prototype.jpg, factory.jpg, mission.jpg, logo.png"
  echo "Optionally: index.html"
  exit 1
fi

if [[ ! "$MONTH" =~ ^[0-9]{4}-[0-9]{2}$ ]]; then
  echo "✗ Month must be in YYYY-MM format (got: $MONTH)"
  exit 1
fi

if [[ ! -d "$SRC" ]]; then
  echo "✗ Source folder not found: $SRC"
  exit 1
fi

cd "$(dirname "$0")"

echo "→ Pulling latest…"
git pull --quiet

echo "→ Creating $MONTH/…"
mkdir -p "$MONTH"

echo "→ Copying assets…"
for f in hero.jpg prototype.jpg factory.jpg mission.jpg logo.png index.html; do
  if [[ -f "$SRC/$f" ]]; then
    cp "$SRC/$f" "$MONTH/$f"
    echo "  ✓ $f"
  fi
done

echo "→ Committing…"
git add "$MONTH"
git commit -m "Add $MONTH images" --quiet

echo "→ Pushing…"
git push --quiet

echo ""
echo "✓ Published. Wait ~1 minute for Pages to deploy, then assets are live at:"
echo ""
echo "  https://nowa-technologies.github.io/nowa-investor-updates/$MONTH/"
echo ""
echo "Image URLs to use in the email HTML:"
for f in hero.jpg prototype.jpg factory.jpg mission.jpg logo.png; do
  if [[ -f "$MONTH/$f" ]]; then
    echo "  https://nowa-technologies.github.io/nowa-investor-updates/$MONTH/$f"
  fi
done
