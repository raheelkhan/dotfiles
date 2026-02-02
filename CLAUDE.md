# Dotfiles Project

## Goal
Fully reproducible development environment setup. Clone repo + run `./setup.sh` = working system.

## What's Here
- **nvim/** - Neovim VSCode-like config (lazy.nvim, LSP, Telescope, NvimTree)
- **zsh/** - Zsh config with nvm/pyenv/rbenv auto-switching
- **vscode/** - VSCode settings backup
- **setup.sh** - Auto-installs everything and creates symlinks

## Current Status

### Working
- Neovim: file explorer, tabs, fuzzy finder, git signs, terminal
- LSP: TypeScript, Python, Ruby, Bash, JSON, YAML, Lua
- Ruby LSP: Uses rbenv shim directly (not Mason) for version detection
- Setup script: Installs brew, nvim, nvm, pyenv, rbenv, go, ripgrep, fd

### Key Architecture Decisions
- **lazy.nvim** (plugin manager) not LazyVim (distribution) - full control
- **Space** as leader key for cross-platform portability
- **rbenv shim** for Ruby LSP instead of Mason (version manager compatibility)
- **NvimTree** as file picker (full screen when no files, sidebar when editing)

## Neovim Workflow
1. `nvim .` → NvimTree file picker
2. Open file → Sidebar + editor split
3. `Space q` → Close file
4. `Space e` → Toggle sidebar
5. `Space ff` → Fuzzy find files

## Files to Edit
Always edit in this repo - they're symlinked:
- `nvim/init.lua` → `~/.config/nvim/init.lua`
- `zsh/.zshrc` → `~/.zshrc`

## Next Steps
- [ ] Test on clean machine
- [ ] Write Substack article about the setup
- [ ] Add Brewfile for GUI apps
