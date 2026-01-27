# Dots

Personal dotfiles for macOS development environment.

## What's Included

| Config | Description |
|--------|-------------|
| **nvim** | Neovim (Kickstart.nvim + Tokyo Night) |
| **shell** | Zsh/Bash configuration |
| **git** | Git configuration |
| **oh-my-posh** | Terminal prompt theme |
| **fastfetch** | System info display |
| **btop** | System monitor |
| **ghostty** | Ghostty terminal emulator |

## Installation

### Quick Install

```bash
cd ~/.dotfiles
./install.sh
```

### Manual Installation

Clone to a new machine:

```bash
git clone https://github.com/YOUR_USERNAME/Dots.git ~/.dotfiles
cd ~/.dotfiles
chmod +x install.sh
./install.sh
```

## Structure

```
~/.dotfiles/
├── config/
│   ├── nvim/           # Neovim configuration
│   ├── oh-my-posh/     # Prompt theme
│   ├── fastfetch/      # System info config
│   ├── btop/           # System monitor
│   ├── ghostty/        # Terminal config
├── shell/
│   ├── .zshrc          # Zsh config
│   ├── .bashrc         # Bash config
│   ├── .bash_profile   # Bash profile
│   └── .zprofile       # Zsh profile
├── git/
│   └── .gitconfig      # Git configuration
├── install.sh          # Installation script
└── README.md           # This file
```

## Adding New Configs

1. Add the config to the appropriate directory in `~/.dotfiles/`
2. Update `install.sh` to create the symlink
3. Commit and push

## Updating

```bash
cd ~/.dotfiles
git pull
./install.sh  # Re-run to apply any new symlinks
```

## Dependencies

This setup assumes the following are installed:

- [Neovim](https://neovim.io/) (0.10+)
- [Oh My Posh](https://ohmyposh.dev/)
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch)
- [btop](https://github.com/aristocratos/btop)
- [Ghostty](https://ghostty.org/)
- [GitHub CLI](https://cli.github.com/)
- A [Nerd Font](https://www.nerdfonts.com/)

### Install on macOS with Homebrew

```bash
brew install neovim jandedobbeleer/oh-my-posh/oh-my-posh fastfetch btop gh
brew install --cask ghostty
```

## Notes

- The `install.sh` script backs up existing configs before replacing them
- Backups are stored in `~/.dotfiles_backup/` with timestamps
- GitHub CLI `hosts.yml` is excluded (contains auth tokens)

---

*Managed with love and symlinks*
