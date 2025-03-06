#!/bin/bash

echo "🔧 Installing Macki..."

# Ensure Homebrew is installed
if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew is not installed. Please install it from https://brew.sh/ and run this script again."
    exit 1
fi

# Install SwiftBar using Homebrew if not already installed
if ! command -v swiftbar &> /dev/null; then
    echo "📦 Installing SwiftBar via Homebrew..."
    brew install --cask swiftbar
    if [ $? -ne 0 ]; then
        echo "❌ SwiftBar installation failed. Try installing manually: https://github.com/swiftbar/SwiftBar/releases"
        exit 1
    fi
else
    echo "✅ SwiftBar is already installed."
fi

# Ensure SwiftBar Plugin Folder is set
PLUGIN_DIR="$HOME/.swiftbar-plugins"
mkdir -p "$PLUGIN_DIR"

# Set SwiftBar preferences programmatically
defaults write com.ameba.SwiftBar PluginDirectory "$PLUGIN_DIR"
defaults write com.ameba.SwiftBar AutomaticallyCheckForUpdates -bool true
defaults write com.ameba.SwiftBar SuppressFirstTimeMessage -bool true
defaults write com.ameba.SwiftBar ShowPluginDebugInfo -bool false
defaults write com.ameba.SwiftBar ShowHiddenPlugins -bool false

# Apply settings immediately
killall SwiftBar 2>/dev/null  # Ensure any running instance restarts with new settings


# Copy Macki script to SwiftBar plugins with a 60s refresh interval
echo "📂 Copying Macki script to SwiftBar plugins..."
cp macki.sh "$PLUGIN_DIR/macki.60s.sh"
chmod +x "$PLUGIN_DIR/macki.60s.sh"

# Ensure SwiftBar is running
if ! pgrep -x "SwiftBar" > /dev/null; then
    echo "🚀 Launching SwiftBar..."
    open -a SwiftBar
    sleep 2  # Give SwiftBar time to initialize
fi

# Refresh macOS app index
echo "🔄 Refreshing macOS app index..."
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f /Applications/SwiftBar.app

echo "✅ Macki installation complete! It should now appear in your menu bar."
