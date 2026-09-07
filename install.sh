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
mkdir -p ~/.config/nvim
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/gitui
mkdir -p ~/.config/aerospace
mkdir -p ~/.config/borders
mkdir -p ~/.config/fastfetch

# make configuration scripts executable
chmod +x ~/.dotfiles/config/borders/bordersrc
chmod +x ~/.dotfiles/config/sketchybar/plugins/aerospace.sh

# create symlinks for configurations
echo "creating symlinks..."
ln -sf ~/.dotfiles/config/nvim ~/.config/nvim
ln -sf ~/.dotfiles/config/ghostty ~/.config/ghostty
ln -sf ~/.dotfiles/config/gitui ~/.config/gitui
ln -sf ~/.dotfiles/config/starship.toml ~/.config/starship.toml
ln -sf ~/.dotfiles/config/zshrc ~/.zshrc
ln -sf ~/.dotfiles/config/aerospace/aerospace.toml ~/.config/aerospace/aerospace.toml
ln -sf ~/.dotfiles/config/borders/bordersrc ~/.config/borders/bordersrc
ln -sf ~/.dotfiles/config/fastfetch/config.jsonc ~/.config/fastfetch/config.jsonc
ln -sf ~/.dotfiles/config/sketchybar ~/.config/sketchybar

# create directories for wallpaper-shuffle state, launch agent, and vicinae script
mkdir -p ~/.local/state/wallpaper-shuffle
mkdir -p ~/Library/LaunchAgents
mkdir -p ~/.local/share/vicinae/scripts

# make wallpaper-shuffle scripts executable
chmod +x ~/.dotfiles/scripts/wallpaper-shuffle.sh
chmod +x ~/.dotfiles/scripts/wallpaper-shuffle-trigger.sh
chmod +x ~/.dotfiles/scripts/shuffle-wallpaper.sh

# generate the wallpaper-shuffle LaunchAgent for this machine
cat > ~/Library/LaunchAgents/com.jewaniuk.wallpapershuffle.plist <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.jewaniuk.wallpapershuffle</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$HOME/.dotfiles/scripts/wallpaper-shuffle.sh</string>
    </array>
    <key>RunAtLoad</key>
    <true/>
    <key>KeepAlive</key>
    <true/>
    <key>StandardOutPath</key>
    <string>$HOME/.local/state/wallpaper-shuffle/daemon.log</string>
    <key>StandardErrorPath</key>
    <string>$HOME/.local/state/wallpaper-shuffle/daemon.err.log</string>
</dict>
</plist>
EOF

# symlink the vicinae script command
ln -sf ~/.dotfiles/scripts/shuffle-wallpaper.sh ~/.local/share/vicinae/scripts/shuffle-wallpaper.sh

# load the wallpaper-shuffle daemon
launchctl bootout "gui/$(id -u)" ~/Library/LaunchAgents/com.jewaniuk.wallpapershuffle.plist 2>/dev/null
launchctl bootstrap "gui/$(id -u)" ~/Library/LaunchAgents/com.jewaniuk.wallpapershuffle.plist

# create file that disables top message on new terminal windows
touch ~/.hushlogin

echo "✨ environment setup complete!"
