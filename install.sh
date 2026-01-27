#!/bin/bash

# Dots - Dotfiles Installation Script
# This script creates symlinks from your home directory to the dotfiles

set -e

DOTFILES_DIR="$HOME/.dotfiles"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}           Dots - Dotfiles Installer              ${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Function to create symlink with backup
link_file() {
    local src=$1
    local dst=$2
    local name=$3

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
            echo -e "  ${GREEN}✓${NC} $name (already linked)"
            return
        fi

        # Backup existing file/directory
        mkdir -p "$BACKUP_DIR"
        echo -e "  ${YELLOW}→${NC} Backing up existing $name to $BACKUP_DIR"
        mv "$dst" "$BACKUP_DIR/"
    fi

    # Create parent directory if needed
    mkdir -p "$(dirname "$dst")"

    # Create symlink
    ln -s "$src" "$dst"
    echo -e "  ${GREEN}✓${NC} $name"
}

# Shell configs
echo -e "${BLUE}Shell configs:${NC}"
link_file "$DOTFILES_DIR/shell/.zshrc" "$HOME/.zshrc" ".zshrc"
link_file "$DOTFILES_DIR/shell/.bashrc" "$HOME/.bashrc" ".bashrc"
link_file "$DOTFILES_DIR/shell/.bash_profile" "$HOME/.bash_profile" ".bash_profile"
link_file "$DOTFILES_DIR/shell/.zprofile" "$HOME/.zprofile" ".zprofile"
echo ""

# Git config
echo -e "${BLUE}Git config:${NC}"
link_file "$DOTFILES_DIR/git/.gitconfig" "$HOME/.gitconfig" ".gitconfig"
echo ""

# .config directory items
echo -e "${BLUE}Config directory (~/.config):${NC}"
link_file "$DOTFILES_DIR/config/nvim" "$HOME/.config/nvim" "nvim"
link_file "$DOTFILES_DIR/config/oh-my-posh" "$HOME/.config/oh-my-posh" "oh-my-posh"
link_file "$DOTFILES_DIR/config/fastfetch" "$HOME/.config/fastfetch" "fastfetch"
link_file "$DOTFILES_DIR/config/btop" "$HOME/.config/btop" "btop"
# gh CLI excluded (contains auth tokens in hosts.yml)
echo ""

# Ghostty (Application Support on macOS)
echo -e "${BLUE}Ghostty terminal:${NC}"
if [[ "$OSTYPE" == "darwin"* ]]; then
    GHOSTTY_DIR="$HOME/Library/Application Support/com.mitchellh.ghostty"
    mkdir -p "$GHOSTTY_DIR"
    link_file "$DOTFILES_DIR/config/ghostty/config" "$GHOSTTY_DIR/config" "ghostty config"
else
    link_file "$DOTFILES_DIR/config/ghostty" "$HOME/.config/ghostty" "ghostty"
fi
echo ""

# Done
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}Installation complete!${NC}"
echo ""

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Backups saved to: $BACKUP_DIR${NC}"
    echo ""
fi

echo -e "To apply shell changes, run: ${BLUE}source ~/.zshrc${NC}"
echo ""
