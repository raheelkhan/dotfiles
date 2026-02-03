#!/bin/bash
# ==============================================================================
# Dotfiles Setup Script
# ==============================================================================
# This script sets up a new machine with all configs and tools.
# Run this after cloning the repo.
#
# Usage: ./setup.sh
# ==============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.config-backup/$(date +%Y%m%d-%H%M%S)"

echo "Dotfiles Setup"
echo "=============="
echo "Source: $SCRIPT_DIR"
echo ""

# ------------------------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------------------------
create_symlink() {
    local source="$1"
    local target="$2"
    local name="$3"

    echo -n "[$name] "

    if [ ! -e "$source" ]; then
        echo "SKIP (source not found)"
        return
    fi

    if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        echo "OK (already linked)"
        return
    fi

    if [ -e "$target" ] || [ -L "$target" ]; then
        mkdir -p "$BACKUP_DIR"
        mv "$target" "$BACKUP_DIR/$(basename "$target")"
        echo -n "backed up... "
    fi

    mkdir -p "$(dirname "$target")"
    ln -s "$source" "$target"
    echo "LINKED"
}

check_command() {
    command -v "$1" &> /dev/null
}

# ------------------------------------------------------------------------------
# Install Homebrew (macOS)
# ------------------------------------------------------------------------------
if [ "$(uname)" = "Darwin" ]; then
    echo "Checking Homebrew..."
    if check_command brew; then
        echo "[brew] OK"
    else
        echo "[brew] Installing..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo ""
fi

# ------------------------------------------------------------------------------
# Install core tools
# ------------------------------------------------------------------------------
echo "Checking core tools..."

# Neovim
if check_command nvim; then
    echo "[nvim] OK"
else
    echo -n "[nvim] Installing... "
    if [ "$(uname)" = "Darwin" ]; then
        brew install neovim
    else
        # Linux - use snap or package manager
        sudo snap install nvim --classic 2>/dev/null || sudo apt-get install -y neovim
    fi
    echo "DONE"
fi

# Node.js (via nvm)
if [ -d "$HOME/.nvm" ]; then
    echo "[nvm] OK"
else
    echo -n "[nvm] Installing... "
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    echo "DONE"
fi

# Python (via pyenv)
if check_command pyenv; then
    echo "[pyenv] OK"
else
    echo -n "[pyenv] Installing... "
    if [ "$(uname)" = "Darwin" ]; then
        brew install pyenv
    else
        curl https://pyenv.run | bash
    fi
    echo "DONE"
fi

# Ruby (via rbenv)
if check_command rbenv; then
    echo "[rbenv] OK"
else
    echo -n "[rbenv] Installing... "
    if [ "$(uname)" = "Darwin" ]; then
        brew install rbenv ruby-build
    else
        git clone https://github.com/rbenv/rbenv.git ~/.rbenv
        git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    fi
    echo "DONE"
fi

# Install ruby-lsp for all installed Ruby versions (for neovim LSP)
if check_command rbenv; then
    echo "Installing ruby-lsp for all Ruby versions..."
    for version in $(rbenv versions --bare 2>/dev/null); do
        if RBENV_VERSION="$version" gem list ruby-lsp -i &>/dev/null; then
            echo "[ruby-lsp@$version] OK"
        else
            echo -n "[ruby-lsp@$version] Installing... "
            RBENV_VERSION="$version" gem install ruby-lsp --silent
            echo "DONE"
        fi
    done
fi

# Go
if check_command go; then
    echo "[go] OK"
else
    echo -n "[go] Installing... "
    if [ "$(uname)" = "Darwin" ]; then
        brew install go
    else
        sudo apt-get install -y golang
    fi
    echo "DONE"
fi

# ripgrep (for telescope)
if check_command rg; then
    echo "[ripgrep] OK"
else
    echo -n "[ripgrep] Installing... "
    if [ "$(uname)" = "Darwin" ]; then
        brew install ripgrep
    else
        sudo apt-get install -y ripgrep
    fi
    echo "DONE"
fi

# fd (for telescope)
if check_command fd; then
    echo "[fd] OK"
else
    echo -n "[fd] Installing... "
    if [ "$(uname)" = "Darwin" ]; then
        brew install fd
    else
        sudo apt-get install -y fd-find
    fi
    echo "DONE"
fi

echo ""

# ------------------------------------------------------------------------------
# Create symlinks
# ------------------------------------------------------------------------------
echo "Creating symlinks..."
echo ""

create_symlink "$SCRIPT_DIR/nvim" "$HOME/.config/nvim" "nvim"
create_symlink "$SCRIPT_DIR/zsh/.zshrc" "$HOME/.zshrc" "zshrc"
create_symlink "$SCRIPT_DIR/aerospace/aerospace.toml" "$HOME/.aerospace.toml" "aerospace"

if [ "$(uname)" = "Darwin" ]; then
    create_symlink "$SCRIPT_DIR/vscode/settings.json" "$HOME/Library/Application Support/Code/User/settings.json" "vscode"
else
    create_symlink "$SCRIPT_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json" "vscode"
fi

echo ""

# ------------------------------------------------------------------------------
# Done
# ------------------------------------------------------------------------------
if [ -d "$BACKUP_DIR" ]; then
    echo "Backups saved to: $BACKUP_DIR"
    echo ""
fi

echo "Done!"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal: source ~/.zshrc"
echo "  2. Open nvim (plugins auto-install): nvim"
echo "  3. LSP servers auto-install via Mason on first use"
echo ""
