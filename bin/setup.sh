#!/usr/bin/env bash
set -euo pipefail
OAK="$(cd "$(dirname "$0")/.." && pwd)"

brew install \
  fzf \
  zoxide \
  starship \
  eza \
  bat \
  neovim \
  --quiet 2>&1 | grep -v "already installed" || true

bash "$OAK/bin/sync.sh"
