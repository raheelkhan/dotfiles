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

# Python (uv) — manages versions + packages
# uv reads .python-version automatically
# Use: uv python install 3.12, uv run python, uv sync

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
# TMUX PROJECT SESSIONS
# ==============================================================================
dev() {
  local project="$1"
  local dir="$HOME/Code/$project"

  if [ -z "$project" ]; then
    echo "Usage: dev <project>"
    ls ~/Code/
    return 1
  fi

  if [ ! -d "$dir" ]; then
    echo "No project at $dir"
    return 1
  fi

  if tmux has-session -t "$project" 2>/dev/null; then
    if [ -n "$TMUX" ]; then
      tmux switch-client -t "$project"
    else
      tmux attach-session -t "$project"
    fi
    return
  fi

  tmux new-session -d -s "$project" -c "$dir" -n editor
  tmux send-keys -t "$project":editor "nvim ." Enter
  tmux new-window -t "$project" -c "$dir" -n terminal
  tmux select-window -t "$project":editor

  if [ -n "$TMUX" ]; then
    tmux switch-client -t "$project"
  else
    tmux attach-session -t "$project"
  fi
}

# ==============================================================================
# IMPORT SECRETS
# ==============================================================================
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"


