#!/usr/bin/env bash
set -euo pipefail

if command -v pdflatex >/dev/null 2>&1 &&
   command -v bibtex >/dev/null 2>&1 &&
   command -v latexmk >/dev/null 2>&1; then
  echo "TeX toolchain already installed."
  exit 0
fi

if ! command -v brew >/dev/null 2>&1; then
  echo "error: Homebrew is required to install MacTeX automatically." >&2
  echo "Install Homebrew first, then rerun this script." >&2
  exit 1
fi

echo "Installing MacTeX (full TeX Live, without GUI applications)..."
brew install --cask mactex-no-gui

# Homebrew notes that a fresh shell is normally required after installing
# MacTeX. Refresh the current shell path immediately instead.
eval "$(/usr/libexec/path_helper)"

echo "macOS TeX Live installation complete."
