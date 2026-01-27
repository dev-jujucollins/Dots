# ============================================================================
# PATH Configuration
# ============================================================================
# Consolidate all PATH modifications here (order matters: first = highest priority)
export PATH="$HOME/.pyenv/bin:$HOME/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/go/bin:$HOME/.local/opt/go/bin:$PATH"

# Cache brew prefix for faster startup (avoid multiple calls)
export HOMEBREW_PREFIX="${HOMEBREW_PREFIX:-/opt/homebrew}"
BREW_PREFIX="$HOMEBREW_PREFIX"

# ============================================================================
# Zsh Options & History
# ============================================================================
# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Ignore commands starting with space
setopt HIST_VERIFY            # Show command with history expansion before running
setopt APPEND_HISTORY         # Append to history file, don't overwrite

# Directory navigation
setopt AUTO_CD                # Auto cd (just type directory name)
setopt AUTO_PUSHD             # Make cd push old directory onto stack
setopt PUSHD_IGNORE_DUPS      # Don't push duplicates onto stack
setopt PUSHD_SILENT           # Don't print directory stack after pushd/popd

# Other useful options
setopt CORRECT                # Try to correct spelling of commands
setopt EXTENDED_GLOB          # Enable extended globbing patterns

# ============================================================================
# Key Bindings
# ============================================================================
bindkey -e                    # Use emacs keybindings (default, explicit)
bindkey '^[[A' history-search-backward   # Up arrow: search history backward
bindkey '^[[B' history-search-forward    # Down arrow: search history forward
bindkey '^[[1;5C' forward-word           # Ctrl+Right: move forward one word
bindkey '^[[1;5D' backward-word          # Ctrl+Left: move backward one word
bindkey '^[[H' beginning-of-line         # Home: beginning of line
bindkey '^[[F' end-of-line               # End: end of line
bindkey '^[[3~' delete-char              # Delete key

# ============================================================================
# Completion System
# ============================================================================
autoload -Uz compinit
# Only run compinit once per day (faster startup)
if [[ -n ${HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# Completion options
zstyle ':completion:*' menu select                          # Menu selection
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'   # Case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"     # Colored completion
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'     # Format descriptions
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

# ============================================================================
# Node Version Manager (NVM)
# ============================================================================
export NVM_DIR="$HOME/.nvm"
# Lazy load NVM to improve shell startup time
if [ -s "/opt/homebrew/opt/nvm/nvm.sh" ]; then
  # Only load NVM when needed (lazy loading)
  nvm() {
    unset -f nvm
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
    nvm "$@"
  }
fi

# ============================================================================
# Python Environment (pyenv)
# ============================================================================
export PYENV_ROOT="$HOME/.pyenv"
# Lazy load pyenv to improve shell startup time
pyenv() {
  unset -f pyenv
  eval "$(command pyenv init --path)"
  eval "$(command pyenv init -)"
  pyenv "$@"
}

# ============================================================================
# Aliases
# ============================================================================
# File listing
alias ls="eza --icons"
alias ll='ls -la'
alias la='ls -la'
alias lt='ls --tree'

# Python
alias py=python3
alias python=python3

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Utilities
alias c='clear'
alias copypath='pwd | pbcopy'
alias ff="pokeget psyduck --hide-name | fastfetch --file-raw -"
alias cat='bat'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'

# Custom scripts
alias builder="/Users/julius/bin/./build.sh"

# ============================================================================
# Zsh Plugins & Tools
# ============================================================================
# fzf - fuzzy finder (use local install or fall back to Homebrew)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || \
  [ -f "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

# zoxide - smarter cd
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# zsh-autosuggestions
if [ -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  # Bind Ctrl+Space to accept suggestion
  bindkey '^ ' autosuggest-accept
fi

# zsh-syntax-highlighting (must be sourced last)
if [ -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# ============================================================================
# Environment Variables
# ============================================================================
# Homebrew - hide "New Formulae" and "New Casks" in brew upgrade output
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_UPDATE_REPORT_NEW=1

# envman
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

# ============================================================================
# Prompt Configuration
# ============================================================================
# oh-my-posh - must be loaded after syntax highlighting
if command -v oh-my-posh &> /dev/null; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/zash.omp.json)"
fi
