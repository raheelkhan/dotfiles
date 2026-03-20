# Dotfiles Project

## Goal
Fully reproducible development environment setup. Clone repo + run `./setup.sh` = working system.

## What's Here
- **nvim/** - Neovim config powered by LazyVim (modular plugin files in lua/)
- **tmux/** - Tmux config (vi mode, mouse, Catppuccin theme)
- **zsh/** - Zsh config with oh-my-zsh, nvm/uv/rbenv auto-switching, `dev` command
- **ghostty/** - Ghostty terminal (Dark+ theme, FiraCode Nerd Font)
- **aerospace/** - AeroSpace i3-like tiling window manager
- **claude/** - Claude Code CLI settings (vim mode disabled)
- **setup.sh** - Auto-installs everything and creates symlinks
- **Brewfile** - All Homebrew packages, casks, and fonts

## Key Architecture Decisions
- **LazyVim** distribution for polished defaults, minimal custom config
- **Space** as leader key for cross-platform portability
- **rbenv shim** for Ruby LSP instead of Mason (respects .ruby-version)
- **Floating terminal** (overrides snacks default of bottom)
- **Autoformat disabled** — format manually with `Space c f`
- **VSCode dark theme** (Mofiqul/vscode.nvim) in Neovim
- **Catppuccin mocha** theme in tmux
- **Dark+** theme in Ghostty
- **Claude Code vim mode disabled** — `Esc` exits Neovim terminal mode instead

## Workflow

### Starting a Dev Session
```bash
dev <project>    # e.g. dev nexus, dev dotfiles
```
This creates a tmux session with:
- Window "editor": `nvim .` (auto-opens)
- Window "terminal": shell for git, builds, etc.

If the session already exists, it reattaches. Projects live in `~/Code/`.

### Navigation
- `Ctrl+b n` / `Ctrl+b p` — switch tmux windows
- `Alt+1-9` — switch AeroSpace workspaces
- `Alt+h/j/k/l` — focus between tiled windows (AeroSpace)

### Claude Code
- In Neovim: `Space a c` to toggle Claude Code terminal
- In terminal: `claude --continue` to resume last conversation
- `Esc` exits terminal mode back to Neovim (won't trigger Claude vim mode)

## Neovim Config Structure
```
nvim/
├── init.lua                  # Bootstrap (sets leader, requires lazy)
├── lua/config/
│   ├── lazy.lua              # LazyVim + lang extras (TS, Python, JSON, YAML, Markdown)
│   ├── options.lua           # Vim options (2-space indent, no wrap, system clipboard)
│   └── keymaps.lua           # Custom keymaps (see below)
└── lua/plugins/
    ├── colorscheme.lua       # VSCode dark theme
    ├── editor.lua            # Telescope (ignore node_modules), gitsigns (custom signs)
    ├── lsp.lua               # Mason + ruby_lsp via rbenv shim, venv-lsp for uv/pyenv
    ├── formatting.lua        # Conform + prettierd (manual only, no format-on-save)
    ├── ui.lua                # Floating terminal, bufferline, lualine (vscode theme)
    └── claude.lua            # Claude Code integration (coder/claudecode.nvim)
```

### Neovim Options
- 2-space indent, no line wrap, absolute line numbers
- System clipboard integration (unnamedplus + unnamed)
- Global statusline, persistent undo
- Autoformat off, spell off

## Neovim Keymaps

### Files & Buffers
- `Space w` — Save file
- `Space W` — Save all files
- `Space q` — Close buffer
- `Space wq` — Save and close buffer
- `Space Q` — Quit all
- `Space n` — New file
- `Tab` / `Shift+Tab` — Next/prev buffer
- `Space 1-9` — Jump to buffer by number
- `Space X` — Force close buffer

### Find (Telescope)
- `Space f f` — Find files
- `Space f g` — Find in files (grep)
- `Space f w` — Find word under cursor
- `Space f b` — Find buffers
- `Space f r` — Recent files
- `Space f h` — Find help

### Editing
- `U` — Redo
- `Alt+j/k` — Move line down/up
- `Alt+Shift+j/k` — Duplicate line down/up
- `Space /` — Toggle comment
- `Space a` — Select all
- `Space sr` — Search and replace

### Windows
- `Space sv` — Vertical split
- `Space sh` — Horizontal split
- `Space sc` — Close split
- `Space so` — Close other splits
- `Ctrl+h/j/k/l` — Navigate between splits

### LSP
- `gd` — Go to definition
- `gr` — Find references
- `K` — Hover info
- `Space c a` — Code action
- `Space c f` — Format file (manual)
- `Space r n` — Rename symbol
- `Space d` — Show diagnostic
- `Ctrl+k` — Signature help (insert mode)

### Git (Gitsigns)
- `Space g b` — Blame line
- `Space g p` — Preview hunk
- `Space g r` — Reset hunk
- `]g` / `[g` — Next/prev git hunk

### Claude Code (inside Neovim)
- `Space a c` — Toggle Claude Code terminal
- `Space a f` — Focus Claude Code
- `Space a r` — Resume previous conversation
- `Space a C` — Accept diff
- `Space a D` — Reject diff
- `Space a s` — Send visual selection to Claude (visual mode)
- `Space a b` — Add current buffer to Claude context

### Terminal
- `Esc` — Exit terminal mode to Neovim normal mode

## AeroSpace Window Management
- `Alt+h/j/k/l` — Focus left/down/up/right
- `Alt+Shift+h/j/k/l` — Move window
- `Alt+1-9` — Switch workspace
- `Alt+Shift+1-9` — Move window to workspace
- `Alt+Tab` — Toggle previous workspace
- `Alt+/` — Cycle layout (tiles/horizontal/vertical)
- `Alt+-` / `Alt+=` — Shrink/grow window

### Workspace Assignments
- Workspace 1: Ghostty (accordion horizontal)
- Workspace 2: Google Chrome
- Workspace 3: Mattermost
- Startup: auto-opens Ghostty, Chrome, Mattermost

## Tmux
- Mouse enabled, vi mode in copy mode
- Catppuccin mocha theme (slanted window status)
- Status bar: directory + session name
- Plugins via TPM: catppuccin/tmux

## Ghostty Terminal
- Theme: Dark+
- Font: FiraCode Nerd Font, 16px, ligatures enabled
- Cursor: blinking block
- macOS titlebar style: tabs
- Splits disabled (use tmux instead)

## Zsh
- Oh-my-zsh with af-magic theme
- Plugins: git, zsh-syntax-highlighting, zsh-autosuggestions
- Auto-title: shows directory name in tab (uppercased)
- Version managers auto-switch: nvm (.nvmrc), uv (.python-version), rbenv (.ruby-version)
- `~/.zshrc.local` sourced for secrets/API keys
- PATH includes: ~/bin, ~/.local/bin, go/bin, libpq/bin

## Symlinks (managed by setup.sh)
| Source | Target |
|--------|--------|
| `nvim/` | `~/.config/nvim/` |
| `zsh/.zshrc` | `~/.zshrc` |
| `tmux/tmux.conf` | `~/.tmux.conf` |
| `ghostty/config` | `~/Library/Application Support/com.mitchellh.ghostty/config` |
| `aerospace/aerospace.toml` | `~/.aerospace.toml` |
| `claude/settings.json` | `~/.claude/settings.json` |

## setup.sh Installs
- Homebrew + Brewfile (all packages, casks, fonts)
- Oh My Zsh
- Neovim, nvm, uv, rbenv, Go, ripgrep, fd
- TPM (tmux plugin manager)
- Claude Code CLI
- macOS defaults: fast key repeat (KeyRepeat=1, InitialKeyRepeat=10)
- All symlinks above (with backup of existing files)

## Files to Edit
Always edit in this repo — they're symlinked to system locations:
- `nvim/` — Neovim config
- `zsh/.zshrc` — Shell config
- `tmux/tmux.conf` — Tmux config
- `ghostty/config` — Terminal config
- `aerospace/aerospace.toml` — Window manager config
- `claude/settings.json` — Claude Code settings

## Next Steps
- [ ] Test on clean machine
- [ ] Write Substack article about the setup
