#!/usr/bin/env bash
# Regenerate zagovor-cheatsheet.pdf from zagovor-cheatsheet.typ using Typst.
#
# If Typst isn't already installed, this downloads a pinned, prebuilt
# binary from the official GitHub releases into ./.typst-bin (not a
# system-wide install) and uses that instead.
set -euo pipefail

cd "$(dirname "$0")"

SRC="zagovor-cheatsheet.typ"
OUT="zagovor-cheatsheet.pdf"
TYPST_VERSION="0.15.1"
BIN_DIR=".typst-bin"

typst_cmd=""

if command -v typst >/dev/null 2>&1; then
  typst_cmd="typst"
else
  os="$(uname -s)"
  arch="$(uname -m)"

  case "$arch" in
    x86_64|amd64) arch="x86_64" ;;
    arm64|aarch64) arch="aarch64" ;;
    *) echo "error: unsupported architecture: $arch" >&2; exit 1 ;;
  esac

  case "$os" in
    Darwin) target="${arch}-apple-darwin" ;;
    Linux)  target="${arch}-unknown-linux-musl" ;;
    *) echo "error: unsupported OS: $os (install typst manually: https://github.com/typst/typst)" >&2; exit 1 ;;
  esac

  archive="typst-${target}.tar.xz"
  vendored="$BIN_DIR/${TYPST_VERSION}/typst-${target}/typst"

  if [ ! -x "$vendored" ]; then
    echo "typst not found — downloading Typst v${TYPST_VERSION} (${target})..." >&2
    version_dir="$BIN_DIR/${TYPST_VERSION}"
    mkdir -p "$version_dir"
    url="https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/${archive}"
    curl -fL --progress-bar -o "$version_dir/$archive" "$url"
    tar -xJf "$version_dir/$archive" -C "$version_dir"
    rm -f "$version_dir/$archive"
    chmod +x "$vendored"
  fi

  typst_cmd="$vendored"
fi

"$typst_cmd" compile "$SRC" "$OUT"
echo "wrote $OUT"
