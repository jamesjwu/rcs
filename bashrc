# ~/.bashrc: portable shell configuration
# Source this from your actual ~/.bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# ============================================================================
# History settings
# ============================================================================
HISTCONTROL=ignoreboth      # Don't save duplicates or lines starting with space
shopt -s histappend         # Append to history file, don't overwrite
HISTSIZE=10000              # More history in memory
HISTFILESIZE=20000          # More history on disk

# ============================================================================
# Shell options
# ============================================================================
shopt -s checkwinsize       # Update LINES and COLUMNS after each command
shopt -s globstar           # Enable ** for recursive globbing

# ============================================================================
# Less configuration
# ============================================================================
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# ============================================================================
# Color support
# ============================================================================
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# ============================================================================
# Git prompt function
# ============================================================================
__git_branch() {
    local branch
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
    if [ -n "$branch" ]; then
        echo " ($branch)"
    fi
}

# ============================================================================
# Prompt configuration
# ============================================================================
# Colors
COLOR_RESET='\[\033[00m\]'
COLOR_GREEN='\[\033[01;32m\]'
COLOR_BLUE='\[\033[01;34m\]'
COLOR_PINK='\[\033[01;35m\]'  # Magenta/pink for git branch

# Detect color support
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# Set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}'"${COLOR_GREEN}\u@\h${COLOR_RESET}:${COLOR_BLUE}\w${COLOR_PINK}"'$(__git_branch)'"${COLOR_RESET}\$ "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_branch)\$ '
fi
unset color_prompt

# Set xterm title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# ============================================================================
# Environment
# ============================================================================
export EDITOR=vim
[ -d "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"

# ============================================================================
# Bash completion
# ============================================================================
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ============================================================================
# Source aliases
# ============================================================================
if [ -f "$HOME/rcs/bash_aliases" ]; then
    . "$HOME/rcs/bash_aliases"
elif [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# ============================================================================
# Conda (auto-detect common locations)
# ============================================================================
for CONDA_PATH in "$HOME/anaconda3" "$HOME/miniconda3" "/opt/conda"; do
    if [ -d "$CONDA_PATH" ]; then
        __conda_setup="$("$CONDA_PATH/bin/conda" 'shell.bash' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ============================================================================
# Rust/Cargo
# ============================================================================
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ============================================================================
# Go
# ============================================================================
if [ -d "$HOME/go" ]; then
    export GOPATH="$HOME/go"
    [ -d "$GOPATH/bin" ] && export PATH="$GOPATH/bin:$PATH"
fi
