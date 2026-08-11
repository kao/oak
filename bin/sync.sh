#!/usr/bin/env bash
set -euo pipefail
OAK="$(cd "$(dirname "$0")/.." && pwd)"
CONFIG="$HOME/.config"

link() {
  local src="$1" dst="$2"
  # guard: src must be a real file/dir, not a symlink itself
  if [[ -L "$src" ]]; then
    echo "ERROR  $src is a symlink — fix oak repo first"
    return 1
  fi
  # use realpath to check if dst already correctly points to src
  if [[ -L "$dst" && "$(realpath "$dst" 2>/dev/null)" == "$src" ]]; then
    echo "ok     $dst"
    return
  fi
  # dst exists as real file/dir — only replace if content matches
  if [[ -e "$dst" && ! -L "$dst" ]]; then
    if ! diff -rq "$src" "$dst" &>/dev/null; then
      echo "SKIP   $dst (differs from $src — resolve manually)"
      return
    fi
  fi
  # remove whatever is there (symlink or identical real dir/file) then link
  rm -rf "$dst"
  ln -s "$src" "$dst"
  echo "linked $dst -> $src"
}

mkdir -p "$CONFIG"

link "$OAK/config/kitty"         "$CONFIG/kitty"
link "$OAK/config/nvim"          "$CONFIG/nvim"
link "$OAK/config/zellij"        "$CONFIG/zellij"
link "$OAK/config/starship.toml" "$CONFIG/starship.toml"
link "$OAK/config/iterm2"        "$CONFIG/iterm2"

link "$OAK/dotfiles/gitconfig"        "$HOME/.gitconfig"
link "$OAK/dotfiles/gitignore_global" "$HOME/.gitignore_global"
link "$OAK/dotfiles/zshrc"            "$HOME/.zshrc"

mkdir -p "$CONFIG/fish"
link "$OAK/dotfiles/config.fish" "$CONFIG/fish/config.fish"

defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$OAK/config/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
echo "iterm2 prefs -> $OAK/config/iterm2"
