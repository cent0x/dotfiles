#!/bin/bash
# This script automates the setup of command-line tools and dotfiles.
# It is designed for Debian-based systems (like Ubuntu) and should be run with sudo.

# Exit immediately if a command exits with a non-zero status.
set -e

# Prompt for sudo password at the beginning to avoid multiple prompts later.
# This will keep the sudo timestamp valid for a few minutes.
sudo -v

# --- 1. System Update and Package Installation ---
echo "--- Updating and upgrading system packages ---"
sudo apt update
sudo apt upgrade -y

echo "--- Checking and installing Zsh ---"
# Check if the current shell is Zsh.
if [[ "$SHELL" != *"/zsh" ]]; then
    echo "Zsh is not the current shell. Installing Zsh..."
    sudo apt install zsh -y
    # Change the default shell to Zsh for the current user.
    echo "Changing default shell to Zsh. You will be prompted for your password."
    chsh -s $(which zsh)
else
    echo "Zsh is already the current shell. Skipping installation."
fi

echo "--- Installing essential command-line tools ---"
# Install all required packages in a single command.
# apt automatically skips packages that are already installed.
sudo apt install -y tree stow unzip eza ripgrep luarocks bat gcc git curli neovim

# Check if 'bat' is available. If not, create a symlink from 'batcat'.
if ! command -v bat &> /dev/null; then
    echo "Creating 'bat' symlink for 'batcat'..."
    sudo ln -s $(which batcat) /usr/local/bin/bat
fi

# --- 2. Installation of Fzf ---
echo "--- Installing fzf ---"
if [ -d "$HOME/.fzf" ]; then
    echo "fzf directory already exists. Skipping git clone and install."
else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install --all
fi

# --- 3. Installation of Zinit (Zsh Plugin Manager) ---
echo "--- Installing zinit ---"
# The Zinit install script will handle an existing installation, but we can add a check for the directory.
if [ -d "$HOME/.zinit" ]; then
    echo "Zinit is already installed. Skipping."
else
    bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# --- 4. Installation of Oh My Posh ---
echo "--- Installing Oh My Posh ---"
if command -v oh-my-posh &> /dev/null; then
    echo "Oh My Posh is already installed. Skipping."
else
    curl -s https://ohmyposh.dev/install.sh | bash -s
fi

# --- 5. Installation of TPM (Tmux Plugin Manager) ---
echo "--- Installing TPM ---"
if [ -d "$HOME/.config/tmux/plugins/tpm" ]; then
    echo "TPM is already installed. Skipping."
else
    git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
fi

# --- 6. Dotfile Management with Stow ---
echo "--- Backing up existing .zshrc and cloning dotfiles ---"
# Check if a .zshrc file exists before trying to move it.
if [ -f "$HOME/.zshrc" ]; then
    mv "$HOME/.zshrc" "$HOME/.zshrc.bak"
    echo "Existing .zshrc file backed up to .zshrc.bak"
else
    echo "No .zshrc file found to back up."
fi

echo "--- Creating symlinks using Stow ---"
cd "$HOME/dotfiles"
stow ohmy
stow zsh
stow tmux
stow nvim

echo "--- Setup complete! ---"
echo "Please log out and log back in, or run 'exec zsh' to use your new shell and configuration."

