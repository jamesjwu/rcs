#!/bin/bash
# Setup script for dev environment
# Run with: bash setup.sh

set -e

echo "=== Dev Environment Setup ==="

# ============================================================================
# Detect OS and package manager
# ============================================================================
if [[ -f /etc/debian_version ]]; then
    PKG_MANAGER="apt"
    INSTALL_CMD="sudo apt update && sudo apt install -y"
elif [[ -f /etc/redhat-release ]]; then
    PKG_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y"
elif [[ -f /etc/arch-release ]]; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
else
    echo "Unsupported Linux distribution"
    exit 1
fi

echo "Detected package manager: $PKG_MANAGER"

# ============================================================================
# Install dependencies
# ============================================================================
echo ""
echo "=== Installing dependencies ==="

if [[ "$PKG_MANAGER" == "apt" ]]; then
    sudo apt update
    sudo apt install -y zsh git curl wget vim
elif [[ "$PKG_MANAGER" == "yum" ]]; then
    sudo yum install -y zsh git curl wget vim
elif [[ "$PKG_MANAGER" == "pacman" ]]; then
    sudo pacman -S --noconfirm zsh git curl wget vim
fi

echo "Installed: zsh, git, curl, wget, vim"

# ============================================================================
# Install Oh My Zsh
# ============================================================================
echo ""
echo "=== Installing Oh My Zsh ==="

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    echo "Oh My Zsh already installed, skipping..."
else
    # Install without switching shell immediately (we'll do it at the end)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    echo "Oh My Zsh installed"
fi

# ============================================================================
# Install zsh plugins
# ============================================================================
echo ""
echo "=== Installing zsh plugins ==="

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# zsh-autosuggestions
if [[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    echo "zsh-autosuggestions already installed, skipping..."
else
    git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
    echo "Installed zsh-autosuggestions"
fi

# zsh-syntax-highlighting (bonus, useful to have)
if [[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    echo "zsh-syntax-highlighting already installed, skipping..."
else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
    echo "Installed zsh-syntax-highlighting"
fi

# ============================================================================
# Set up rc files
# ============================================================================
echo ""
echo "=== Setting up rc files ==="

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Backup existing files
for rc in .bashrc .zshrc .vimrc; do
    if [[ -f "$HOME/$rc" && ! -L "$HOME/$rc" ]]; then
        echo "Backing up existing $rc to $rc.bak"
        mv "$HOME/$rc" "$HOME/$rc.bak"
    fi
done

# Create ~/.bashrc that sources our bashrc
cat > "$HOME/.bashrc" << 'EOF'
# ~/.bashrc - minimal loader for portable rcs setup
# The actual configuration lives in ~/rcs/bashrc

if [ -f "$HOME/rcs/bashrc" ]; then
    . "$HOME/rcs/bashrc"
fi
EOF
echo "Created ~/.bashrc"

# Create ~/.zshrc that sources our zshrc
cat > "$HOME/.zshrc" << 'EOF'
# ~/.zshrc - minimal loader for portable rcs setup
# The actual configuration lives in ~/rcs/zshrc

if [[ -f "$HOME/rcs/zshrc" ]]; then
    source "$HOME/rcs/zshrc"
fi
EOF
echo "Created ~/.zshrc"

# Symlink vimrc
ln -sf "$HOME/rcs/vimrc" "$HOME/.vimrc"
echo "Created ~/.vimrc -> ~/rcs/vimrc"

# Create vim undo directory
mkdir -p "$HOME/.vim/undodir"

# ============================================================================
# Change default shell to zsh
# ============================================================================
echo ""
echo "=== Setting zsh as default shell ==="

if [[ "$SHELL" != *"zsh"* ]]; then
    chsh -s "$(which zsh)"
    echo "Default shell changed to zsh (will take effect on next login)"
else
    echo "zsh is already the default shell"
fi

# ============================================================================
# Done
# ============================================================================
echo ""
echo "=== Setup complete! ==="
echo ""
echo "Files created:"
echo "  ~/.bashrc  -> sources ~/rcs/bashrc"
echo "  ~/.zshrc   -> sources ~/rcs/zshrc"
echo "  ~/.vimrc   -> symlink to ~/rcs/vimrc"
echo ""
echo "To start using zsh now, run: zsh"
echo "Or log out and log back in."
