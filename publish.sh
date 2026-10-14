#!/usr/bin/env bash
# Build the site, commit + push the source, and publish to GitHub Pages.
# Usage: ./publish.sh "Commit message"
set -euo pipefail
cd "$(dirname "$0")"

msg="${1:-Update site}"

echo "==> Rendering site"
quarto render

echo "==> Committing and pushing"
git add .
if git diff --cached --quiet; then
  echo "Nothing new to commit, skipping commit."
else
  git commit -m "$msg"
fi
git push

echo "==> Publishing to GitHub Pages"
quarto publish gh-pages --no-prompt --no-render

echo "Done: https://arvindkalyan.github.io"
