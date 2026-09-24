#!/usr/bin/env bash
set -euo pipefail

if command -v pdflatex >/dev/null 2>&1 &&
   command -v bibtex >/dev/null 2>&1 &&
   command -v latexmk >/dev/null 2>&1; then
  echo "TeX toolchain already installed."
  exit 0
fi

if [[ "$(id -u)" -eq 0 ]]; then
  SUDO=()
elif command -v sudo >/dev/null 2>&1; then
  SUDO=(sudo)
else
  echo "error: root privileges or sudo are required." >&2
  exit 1
fi

echo "Installing TeX Live via apt..."
"${SUDO[@]}" apt-get update
"${SUDO[@]}" env DEBIAN_FRONTEND=noninteractive apt-get install -y texlive-full

echo "Debian TeX Live installation complete."
