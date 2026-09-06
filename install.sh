#!/usr/bin/env bash

# install homebrew if not installed
if ! command -v brew &> /dev/null; then
    echo "installing homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# install all Brewfile dependencies
echo "installing dependencies..."
brew bundle --file=~/.dotfiles/Brewfile

# install google antigravity cli
echo "installing antigravity cli..."
curl -fsSL https://antigravity.google/cli/install.sh | bash

# create ~/.config directories if they don't exist
mkdir -p ~/.config
mkdir -p ~/.config/aerospace
mkdir -p ~/.config/borders

# create symlinks for configurations
echo "creating symlinks..."
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/config/ghostty ~/.config/ghostty
ln -sf ~/.dotfiles/config/gitui ~/.config/gitui
ln -sf ~/.dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/.dotfiles/config/zshrc ~/.zshrc
ln -sf ~/.dotfiles/config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/.dotfiles/config/borders/bordersrc ~/.config/borders/bordersrc

# create file that disables top message on new terminal windows
touch ~/.hushlogin

echo "✨ environment setup complete!"
