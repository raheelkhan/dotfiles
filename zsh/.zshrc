# ==============================================================================
# PATH
# ==============================================================================
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export PATH="$HOME/.gem:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

# ==============================================================================
# OH MY ZSH
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="af-magic"
COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
plugins=(git)
source "$ZSH/oh-my-zsh.sh"

# ==============================================================================
# SHELL ENHANCEMENTS
# ==============================================================================
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# ==============================================================================
# VERSION MANAGERS
# ==============================================================================
# Node (nvm) with auto-switch on .nvmrc
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Auto-switch node version when entering directory with .nvmrc
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc  # Run on shell start

# Python (pyenv) with auto-switch on .python-version
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
# pyenv auto-switches via .python-version by default

# Ruby (rbenv) with auto-switch on .ruby-version
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
# rbenv auto-switches via .ruby-version by default

# ==============================================================================
# TERMINAL TITLE
# ==============================================================================
# Show current directory name as tab title (e.g., "dotfiles" not "~/Code/dotfiles")
precmd() { echo -ne "\e]0;${(U)PWD##*/}\a"; }

# ==============================================================================
# IMPORT SECRETS
# ==============================================================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"


