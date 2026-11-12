#!/usr/bin/env bash
# Symlink oak configs into $HOME. Safe to re-run.
#   -n, --dry-run   show what would change without touching anything
set -euo pipefail
OAK="$(cd "$(dirname "$0")/.." && pwd -P)"
CONFIG="$HOME/.config"

DRY_RUN=0
case "${1:-}" in
  -n | --dry-run) DRY_RUN=1 ;;
  "") ;;
  *) echo "usage: $0 [-n|--dry-run]" >&2; exit 2 ;;
esac

run() {
  if (( DRY_RUN )); then
    echo "       would run: $*"
  else
    "$@"
  fi
}

link() {
  local src="$1" dst="$2"
  if [[ ! -e "$src" ]]; then
    echo "ERROR  $src does not exist"
    return 1
  fi
  # guard: src must be a real file/dir, not a symlink itself
  if [[ -L "$src" ]]; then
    echo "ERROR  $src is a symlink — fix oak repo first"
    return 1
  fi
  if [[ -L "$dst" ]]; then
    if [[ "$(realpath "$dst" 2>/dev/null)" == "$src" ]]; then
      echo "ok     $dst"
      return
    fi
    # symlink managed by something else: leave it alone
    echo "SKIP   $dst -> $(readlink "$dst") (foreign symlink — resolve manually)"
    return
  fi
  if [[ -e "$dst" ]]; then
    if diff -rq "$src" "$dst" &>/dev/null; then
      run rm -rf "$dst"
    else
      local backup
      backup="$dst.bak.$(date +%Y%m%d%H%M%S)"
      echo "backup $dst -> $backup"
      run mv "$dst" "$backup"
    fi
  fi
  run mkdir -p "$(dirname "$dst")"
  run ln -s "$src" "$dst"
  (( DRY_RUN )) || echo "linked $dst -> $src"
}

link "$OAK/config/kitty"              "$CONFIG/kitty"
link "$OAK/config/nvim"               "$CONFIG/nvim"
link "$OAK/config/starship.toml"      "$CONFIG/starship.toml"
link "$OAK/dotfiles/config.fish"      "$CONFIG/fish/config.fish"

link "$OAK/dotfiles/gitconfig"        "$HOME/.gitconfig"
link "$OAK/dotfiles/gitignore_global" "$HOME/.gitignore_global"
link "$OAK/dotfiles/psqlrc"           "$HOME/.psqlrc"
link "$OAK/dotfiles/gemrc"            "$HOME/.gemrc"
