#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

die() {
  printf 'error: %s\n' "$*" >&2
  exit 1
}

verify_unix_toolchain() {
  local missing=0

  for cmd in pdflatex bibtex latexmk; do
    if command -v "$cmd" >/dev/null 2>&1; then
      printf 'found: %-8s %s\n' "$cmd" "$(command -v "$cmd")"
    else
      printf 'missing: %s\n' "$cmd" >&2
      missing=1
    fi
  done

  if [[ "$missing" -ne 0 ]]; then
    die "TeX toolchain installation finished, but required commands are not available on PATH."
  fi
}

run_windows_installer() {
  local ps_script="$SCRIPT_DIR/windows/install.ps1"
  local shell_path="$ps_script"

  if command -v cygpath >/dev/null 2>&1; then
    shell_path="$(cygpath -w "$ps_script")"
  fi

  if command -v powershell.exe >/dev/null 2>&1; then
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$shell_path"
  elif command -v pwsh.exe >/dev/null 2>&1; then
    pwsh.exe -NoProfile -ExecutionPolicy Bypass -File "$shell_path"
  else
    die "PowerShell is required for the Windows installer."
  fi
}

case "$(uname -s)" in
  Darwin)
    "$SCRIPT_DIR/macos/install.sh"
    verify_unix_toolchain
    ;;
  Linux)
    if ! command -v apt-get >/dev/null 2>&1; then
      die "Unsupported Linux distribution. This installer currently supports Debian-based systems with apt-get."
    fi

    "$SCRIPT_DIR/debian/install.sh"
    verify_unix_toolchain
    ;;
  MINGW*|MSYS*|CYGWIN*)
    run_windows_installer
    ;;
  *)
    die "Unsupported operating system: $(uname -s)"
    ;;
esac

printf '\nTeX toolchain is ready.\n'
