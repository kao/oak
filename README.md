# oak

Personal macOS dotfiles: fish, starship, neovim (LazyVim), kitty, git, psql.

## Fresh Mac

1. Install [Homebrew](https://brew.sh).
2. Clone this repo (anywhere; links use its real path):
   ```sh
   git clone https://github.com/kao/oak.git ~/code/private/oak
   ```
3. Install packages and link configs:
   ```sh
   ~/code/private/oak/bin/setup.sh
   ```
4. Make fish the login shell:
   ```sh
   echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
   chsh -s /opt/homebrew/bin/fish
   ```

## Day to day

- `bin/sync.sh` re-links configs; safe to re-run. `bin/sync.sh -n` shows what it would do.
  Existing files that differ are moved to `<name>.bak.<timestamp>`; symlinks pointing
  elsewhere are left alone.
- Add a package: edit `Brewfile`, then `brew bundle`.

## Layout

- `config/` — linked into `~/.config/`
- `dotfiles/` — linked into `~` (plus `config.fish` into `~/.config/fish/`)
- `bin/` — setup scripts
