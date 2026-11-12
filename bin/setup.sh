#!/usr/bin/env bash
set -euo pipefail
OAK="$(cd "$(dirname "$0")/.." && pwd -P)"

if ! command -v brew >/dev/null; then
  echo "Homebrew is required: https://brew.sh" >&2
  exit 1
fi

brew bundle --file "$OAK/Brewfile"

bash "$OAK/bin/sync.sh" "$@"
