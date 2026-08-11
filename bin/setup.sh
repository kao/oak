#!/usr/bin/env bash
set -euo pipefail
OAK="$(cd "$(dirname "$0")/.." && pwd)"

brew install \
  zsh-autosuggestions \
  zsh-fast-syntax-highlighting \
  fzf \
  zoxide \
  starship \
  eza \
  bat \
  neovim \
  --quiet 2>&1 | grep -v "already installed" || true

bash "$OAK/bin/sync.sh"
