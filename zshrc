# ============================================================================
# Oh My Zsh configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"

# Using custom prompt below, so disable theme
ZSH_THEME=""

# Plugins (zsh-syntax-highlighting must be last)
plugins=(git gitfast command-not-found python pip zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# ============================================================================
# Prompt - user@host:path (branch) with git branch in pink
# ============================================================================
PROMPT='%{$fg_bold[green]%}%n@%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%# '
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[magenta]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[magenta]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg_bold[magenta]%})"

# ============================================================================
# History settings
# ============================================================================
HISTSIZE=10000
SAVEHIST=20000
setopt HIST_IGNORE_DUPS       # Don't save duplicate lines
setopt HIST_IGNORE_SPACE      # Don't save lines starting with space
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_REDUCE_BLANKS     # Remove extra blanks

# ============================================================================
# Environment
# ============================================================================
export EDITOR=vim
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# Aliases
# ============================================================================
# ls aliases
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# grep aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Safety
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Git shortcuts (most are provided by oh-my-zsh git plugin, these are extras)
alias gs='git status'
alias gl='git log --oneline -20'

# Misc
alias h='history'
alias c='clear'

# ============================================================================
# Conda (auto-detect common locations)
# ============================================================================
for CONDA_PATH in "$HOME/anaconda3" "$HOME/miniconda3" "/opt/conda"; do
    if [[ -d "$CONDA_PATH" ]]; then
        __conda_setup="$("$CONDA_PATH/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
        if [[ $? -eq 0 ]]; then
            eval "$__conda_setup"
        else
            if [[ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]]; then
                . "$CONDA_PATH/etc/profile.d/conda.sh"
            else
                export PATH="$CONDA_PATH/bin:$PATH"
            fi
        fi
        unset __conda_setup
        break
    fi
done
unset CONDA_PATH

# ============================================================================
# NVM (Node Version Manager)
# ============================================================================
export NVM_DIR="$HOME/.nvm"
[[ -s "$NVM_DIR/nvm.sh" ]] && \. "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && \. "$NVM_DIR/bash_completion"

# ============================================================================
# Rust/Cargo
# ============================================================================
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# ============================================================================
# Go
# ============================================================================
if [[ -d "$HOME/go" ]]; then
    export GOPATH="$HOME/go"
    [[ -d "$GOPATH/bin" ]] && export PATH="$GOPATH/bin:$PATH"
fi
