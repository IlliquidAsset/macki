#!/bin/bash

echo "Installing Macki..."

# Define SwiftBar install location
SWIFTBAR_APP="/Applications/SwiftBar.app"

# Check if SwiftBar is installed
if [ ! -d "$SWIFTBAR_APP" ]; then
    echo "SwiftBar not found. Downloading..."
    curl -L https://github.com/swiftbar/SwiftBar/releases/latest/download/SwiftBar.zip -o /tmp/SwiftBar.zip
    unzip /tmp/SwiftBar.zip -d /Applications
    rm /tmp/SwiftBar.zip
    echo "SwiftBar installed."
else
    echo "SwiftBar is already installed."
fi

# Create SwiftBar plugin directory if it doesn't exist
mkdir -p ~/.swiftbar-plugins

# Move Macki script into SwiftBar plugins folder with a 60s refresh interval
cp macki.sh ~/.swiftbar-plugins/macki.60s.sh
chmod +x ~/.swiftbar-plugins/macki.60s.sh

# Start SwiftBar (if not already running)
if ! pgrep -x "SwiftBar" > /dev/null; then
    echo "Launching SwiftBar..."
    open -a SwiftBar
fi

echo "Macki installation complete! It should now appear in the menu bar."