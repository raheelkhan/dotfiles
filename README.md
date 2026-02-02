# System Configuration

My dotfiles and system configuration, managed with git and symlinks.

## Structure

```
system/
├── setup.sh          # Run this on new machines
├── nvim/             # Neovim config → ~/.config/nvim
│   ├── init.lua      # Main config (plugins, options, keymaps)
│   ├── KEYBINDINGS.md
│   └── plugins.txt   # Reference list of plugins
├── zsh/              # Zsh config
│   └── .zshrc        # → ~/.zshrc
└── vscode/           # VSCode config
    └── settings.json # → ~/Library/Application Support/Code/User/settings.json
```

## Setup on New Machine

```bash
# 1. Clone the repo
git clone <your-repo-url> ~/Code/system

# 2. Run setup script (creates symlinks)
cd ~/Code/system
./setup.sh

# 3. Restart terminal
source ~/.zshrc

# 4. Open nvim (plugins auto-install on first launch)
nvim
```

## Workflow

**Always edit files in `~/Code/system/`** - they're symlinked to the actual config locations.

```bash
# Edit nvim config
nvim ~/Code/system/nvim/init.lua

# Changes are immediately reflected because:
# ~/.config/nvim → ~/Code/system/nvim (symlink)
```

## Adding New Configs

1. Move the config to this repo
2. Add symlink creation to `setup.sh`
3. Run `./setup.sh` to create the symlink

Example:
```bash
# Move git config
mv ~/.gitconfig ~/Code/system/git/.gitconfig

# Add to setup.sh:
# create_symlink "$SCRIPT_DIR/git/.gitconfig" "$HOME/.gitconfig" "gitconfig"
```

## Backups

When running `setup.sh`, existing configs are backed up to:
```
~/.config-backup/<timestamp>/
```
