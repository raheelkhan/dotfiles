# Dotfiles Project

## Goal
Fully reproducible development environment setup. Clone repo + run `./setup.sh` = working system.

## What's Here
- **nvim/** - Neovim config powered by LazyVim (modular files in lua/)
- **tmux/** - Tmux config (vi mode, mouse scroll)
- **zsh/** - Zsh config with nvm/pyenv/rbenv auto-switching
- **vscode/** - VSCode settings backup
- **ghostty/** - Ghostty terminal config
- **aerospace/** - AeroSpace window manager config
- **setup.sh** - Auto-installs everything and creates symlinks

## Current Status

### Working
- Neovim: LazyVim with snacks explorer, bufferline tabs, floating terminal, telescope
- LSP: TypeScript, Python, Ruby, Bash, JSON, YAML, Lua
- Ruby LSP: Uses rbenv shim directly (not Mason) for version detection
- Formatting: Prettierd for web languages, manual only (Space c f)
- Setup script: Installs brew, nvim, nvm, pyenv, rbenv, go, ripgrep, fd, tmux

### Key Architecture Decisions
- **LazyVim** (distribution) for polished layout, minimal custom config
- **Space** as leader key for cross-platform portability
- **rbenv shim** for Ruby LSP instead of Mason (version manager compatibility)
- **Snacks explorer** as file picker (LazyVim default)
- **Floating terminal** (snacks default changed to bottom, we override to float)
- **Autoformat disabled** — format manually with Space c f
- **VSCode dark theme** (Mofiqul/vscode.nvim)

## Neovim Config Structure
```
nvim/
├── init.lua                  # Bootstrap (5 lines)
├── lua/config/
│   ├── lazy.lua              # LazyVim + lang extras (TS, Python, JSON, YAML)
│   ├── options.lua           # Vim options
│   └── keymaps.lua           # Custom keymaps
└── lua/plugins/
    ├── colorscheme.lua       # VSCode dark theme
    ├── editor.lua            # Telescope, gitsigns
    ├── lsp.lua               # Mason + ruby_lsp via rbenv
    ├── formatting.lua        # Conform + prettierd (no auto-format)
    └── ui.lua                # Floating terminal, bufferline, lualine
```

## Neovim Keymaps
- `Space e` → Toggle explorer
- `Space f f` → Find files
- `Space f g` → Find in files (grep)
- `Space f t` → Floating terminal
- `Ctrl+/` → Toggle floating terminal (works both ways)
- `Space w` → Save file
- `Space q` → Close buffer
- `Space c f` → Format file (manual)
- `Space g b` → Git blame line
- `gd` → Go to definition
- `gr` → Find references
- `K` → Hover info
- `Space c a` → Code action
- `Space r n` → Rename symbol
- `Tab` / `Shift+Tab` → Next/prev buffer

## Recommended Workflow
1. Open Ghostty tab (one tab per project)
2. `cd` into project, run `tmux`
3. Tmux tab 0: `nvim .` (editor)
4. Tmux tab 1: terminal (commands, Claude Code, etc.)
5. `Ctrl+b n` / `Ctrl+b p` to switch tmux tabs

## Files to Edit
Always edit in this repo — they're symlinked:
- `nvim/` → `~/.config/nvim/`
- `zsh/.zshrc` → `~/.zshrc`
- `tmux/tmux.conf` → `~/.tmux.conf`
- `ghostty/config` → Ghostty config path
- `aerospace/aerospace.toml` → `~/.aerospace.toml`

## Next Steps
- [ ] Test on clean machine
- [ ] Write Substack article about the setup
