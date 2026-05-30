# Dotfiles

My macOS development environment, fully reproducible from a single script.
Clone the repo, run `./setup.sh`, and you get a working system: terminal,
editor, shell, multiplexer, and tiling window manager — all configured and
symlinked into place.

> **Platform:** macOS (built and tested on Apple Silicon; the Homebrew paths
> auto-detect Intel too). `setup.sh` has best-effort Linux fallbacks, but the
> GUI pieces (Ghostty, AeroSpace) are macOS-only.

## What's inside

| Tool | Config | Highlights |
|------|--------|------------|
| **Neovim** | `nvim/` → `~/.config/nvim` | [LazyVim](https://www.lazyvim.org/) base, VSCode dark theme, floating terminal, Ruby LSP via rbenv |
| **Zsh** | `zsh/.zshrc` → `~/.zshrc` | oh-my-zsh, auto-switching nvm/uv/rbenv, `dev` project launcher |
| **tmux** | `tmux/tmux.conf` → `~/.tmux.conf` | vi mode, mouse, Dark+ status bar |
| **Ghostty** | `ghostty/config` → `~/Library/Application Support/com.mitchellh.ghostty/config` | Dark+ theme, FiraCode Nerd Font, ligatures |
| **AeroSpace** | `aerospace/aerospace.toml` → `~/.aerospace.toml` | i3-like tiling WM, `Alt`-driven workspaces |
| **Claude Code** | `claude/settings.json` → `~/.claude/settings.json` | LSP plugins, terminal vim mode off |
| **VSCode** | `vscode/settings.json` | Fira Code, format-on-save, per-language overrides |
| **Homebrew** | `Brewfile` | Every formula, cask, and font in one bundle |

## Quick start

```bash
# 1. Clone
git clone https://github.com/raheelkhan/dotfiles.git ~/Code/dotfiles
cd ~/Code/dotfiles

# 2. Run setup (installs tools + creates symlinks; backs up anything it replaces)
./setup.sh

# 3. Reload your shell
source ~/.zshrc

# 4. Open Neovim — plugins auto-install on first launch
nvim
```

## What `setup.sh` does

- Installs Homebrew, then everything in the `Brewfile` (formulae, casks, fonts)
- Installs oh-my-zsh, nvm, uv, rbenv, Go, ripgrep, fd, tmux's TPM, and the Claude Code CLI (each only if missing)
- Installs the `ruby-lsp` gem into the active rbenv Ruby (for Neovim's Ruby LSP)
- Sets fast macOS key-repeat defaults
- Ad-hoc-signs Neovim tree-sitter parsers (needed on macOS 26.2+)
- Symlinks every config above into place, **backing up existing files** to `~/.config-backup/<timestamp>/`

Re-running is safe and idempotent — already-linked configs are left alone.

## Daily workflow

```bash
dev <project>    # e.g. dev dotfiles
```

`dev` opens (or reattaches to) a tmux session for a project in `~/Code/` with
an `editor` window (`nvim .`) and a `terminal` window.

## Customizing for yourself

This is *my* setup — a few things are personal and you'll likely want to change them:

- **Secrets/API keys** live in `~/.zshrc.local`, which is sourced if present and is **never** part of this repo. Create your own.
- **`aerospace/aerospace.toml`** pins workspaces to an external monitor (`HP*`) and auto-launches specific apps — edit `[workspace-to-monitor-force-assignment]` and the `after-startup-command` / `on-window-detected` blocks.
- **`Brewfile`** includes a few niche tools (`act`, `e1s`) and the Chrome cask — trim to taste before running.
- **`CLAUDE.md`** documents the repo for Claude Code; harmless to keep or delete.

## Adding a new config

1. Move the config file into this repo (e.g. `git/.gitconfig`).
2. Add a `create_symlink` line to `setup.sh`.
3. Re-run `./setup.sh`.

## Layout

```
dotfiles/
├── setup.sh          # one-shot installer + symlinker
├── Brewfile          # all Homebrew packages, casks, fonts
├── CLAUDE.md         # repo guide for Claude Code
├── nvim/             # Neovim (LazyVim) config
├── zsh/.zshrc        # shell config
├── tmux/tmux.conf    # tmux config
├── ghostty/config    # terminal config
├── aerospace/        # tiling window manager config
├── claude/           # Claude Code settings
├── vscode/           # VSCode settings
└── docs/             # setup notes (e.g. Ruby LSP + rbenv)
```
