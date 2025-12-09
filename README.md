# rcs

My personal dotfiles/rc files.

## Contents

- `bashrc` - Bash configuration
- `bash_aliases` - Bash aliases (sourced by bashrc)
- `zshrc` - Zsh configuration (Oh My Zsh)
- `vimrc` - Vim configuration
- `setup.sh` - Setup script for new machines

## Setup

Clone to `~/rcs` and run:

```bash
bash ~/rcs/setup.sh
```

This will:
- Install zsh, vim, git, curl, wget
- Install Oh My Zsh with zsh-autosuggestions and zsh-syntax-highlighting
- Create loader files at `~/.bashrc`, `~/.zshrc`, and symlink `~/.vimrc`
- Set zsh as default shell

Supports Debian/Ubuntu, RHEL/CentOS, and Arch.
