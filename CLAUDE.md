# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a GNU Stow-based dotfiles repository for macOS. Configurations are organized as stow packages — each top-level directory (e.g., `nvim/`, `zsh/`, `tmux/`) mirrors the home directory structure and is symlinked into `~` via stow.

## Key Commands

**Full setup on a new machine:**

```sh
./install.sh
```

**Deploy/update a specific package's symlinks:**

```sh
stow -v -t ~ nvim        # symlink nvim config
stow -v -t ~ zsh         # symlink zsh config
# etc.
```

**Remove a package's symlinks:**

```sh
stow -v -D -t ~ nvim
```

**Install Homebrew packages:**

```sh
brew bundle
```

**Set Neovim version:**

```sh
bob use nightly
```

**Install/update Yazi plugins:**

```sh
ya pkg add yazi-rs/plugins:git
```

## Repository Structure

Each stow package follows XDG conventions — files live under `<package>/.config/<name>/` so they symlink to `~/.config/<name>/`.

**Active stow packages:** `bat`, `git`, `ghostty`, `kmonad`, `nvim`, `ripgrep`, `sesh`, `tmux`, `wezterm`, `yazi`, `zsh`

**Other top-level files:**

- `Brewfile` — all Homebrew dependencies (formulae, casks, Mac App Store apps)
- `install.sh` — full machine setup script
- `.macos` — macOS system defaults (keyboard, trackpad, screenshots, dock, etc.)
- `scripts/` — shell scripts for tmux sessionizer and HUD

## Neovim Architecture

Config lives at `nvim/.config/nvim/`. Structure:

- `init.lua` — bootstraps config modules and implements dynamic line numbering
- `lua/config/` — core settings: `options.lua`, `keymaps.lua`, `autocmds.lua`, `lsp.lua`
- `lua/plugins/` — one file per plugin; all files are auto-loaded by `init.lua` via glob

The plugin system uses **nvim-pack** (lock file: `nvim-pack-lock.json`). Each file in `lua/plugins/` is an independent module returning a plugin spec.

Notable plugins: `blink.cmp` (completion), `telescope`, `conform` (formatting), `codecompanion` (AI), `iron` (REPL), `snacks`, `dap` (debugging), `noice`, `flash`, `grug-far`.

## Zsh Architecture

Config at `zsh/.config/zsh/`. The `.zshrc` sources:

- `zsh-exports` — env vars and PATH
- `zsh-aliases` — command aliases
- `zsh-keybinds` — readline/zle keybindings
- `zsh-functions` — shell functions

Plugins live in `~/.config/zsh/plugins/` (cloned at install time, not tracked in this repo): `forgit`, `fzf-tab`, `zsh-autosuggestions`, `zsh-syntax-highlighting`.

## Tmux Architecture

Config at `tmux/.config/tmux/tmux.conf`. Uses TPM (Tmux Plugin Manager) with plugins: `tmux-resurrect`, `tmux-continuum`, `tmux-fzf`. Session management integrates with `sesh` (config at `sesh/.config/sesh/sesh.toml`).

## Wezterm Architecture

Config at `wezterm/.config/wezterm/wezterm.lua`. Modular design — main file sources: `appearance.lua`, `technical.lua`, `keymaps.lua`, `tabline.lua`, `misc.lua`, `ssh.lua`, `nord.lua`.

## Cross-Tool Integration

- Shell auto-starts Tmux in a "main" session on launch
- Tmux session picker (`Ctrl+F`) uses `sesh` + `fzf`, scanning project directories and package managers (Python, Julia)
- Wezterm/Ghostty keybinds forward to Tmux for pane/window navigation
- Neovim integrates yazi as file picker (via `yazi.lua` plugin)
- `scripts/tmux-sessionizer.sh` handles session creation from project directories

## Stow Ignore Rules

`.stow-local-ignore` excludes: `README.md`, `CLAUDE.md`, `install.sh`, `Brewfile`, `.macos`, `.mackup.cfg`, and the `scripts/` directory from being symlinked.

## Goals

The dotfiles are used for both macOS (personal) and Linux (work). That's why in some configuration files there are OS-dependent lines.
