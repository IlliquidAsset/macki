#!/bin/bash

# Get battery levels for Magic Mouse and Keyboard
MOUSE_BATTERY=$(ioreg -c AppleDeviceManagementHIDEventService -r | grep -A5 "Magic Mouse" | grep BatteryPercent | awk '{print $NF}')
KEYBOARD_BATTERY=$(ioreg -c AppleDeviceManagementHIDEventService -r | grep -A5 "Magic Keyboard" | grep BatteryPercent | awk '{print $NF}')

# Default to "N/A" if not found
MOUSE_BATTERY=${MOUSE_BATTERY:-"N/A"}
KEYBOARD_BATTERY=${KEYBOARD_BATTERY:-"N/A"}

# Output for SwiftBar (this is what shows in the menu bar)
echo "🖱️ $MOUSE_BATTERY% | ⌨️ $KEYBOARD_BATTERY%"
echo "---"
echo "Refresh | refresh=true"