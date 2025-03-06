#!/bin/bash

# Fetch battery levels for Magic Mouse and Keyboard
MOUSE_BATTERY=$(ioreg -c AppleDeviceManagementHIDEventService -r | awk '/"Product" = "Magic Mouse"/ {getline; getline; getline; getline; getline; if ($0 ~ /"BatteryPercent"/) print $NF}')
KEYBOARD_BATTERY=$(ioreg -c AppleDeviceManagementHIDEventService -r | awk '/"Product" = "Magic Keyboard with Numeric Keypad"/ {getline; getline; getline; getline; getline; if ($0 ~ /"BatteryPercent"/) print $NF}')

# Ensure battery values are always displayed correctly
if [[ -z "$MOUSE_BATTERY" ]]; then
    MOUSE_BATTERY="N/A"
else
    MOUSE_BATTERY="${MOUSE_BATTERY}%"
fi

if [[ -z "$KEYBOARD_BATTERY" ]]; then
    KEYBOARD_BATTERY="N/A"
else
    KEYBOARD_BATTERY="${KEYBOARD_BATTERY}%"
fi

# Output formatted battery status for SwiftBar
echo "🖱️ M: $MOUSE_BATTERY | ⌨️ K: $KEYBOARD_BATTERY"
echo "---"
echo "Refresh | refresh=true"