#!/bin/bash
# Screen rotation toggle script for Hyprland
# Cycles through: 0° -> 90° -> 180° -> 270° -> 0° ...
STATE_FILE="$HOME/.config/hypr/rotation_state"
MONITOR_NAME="eDP-1"  # Leave empty for all monitors, or specify like "eDP-1"
# Create state file if it doesn't exist
if [ ! -f "$STATE_FILE" ]; then
    echo "0" > "$STATE_FILE"
fi
# Read current rotation state
current_state=$(cat "$STATE_FILE")
# Calculate next rotation state (cycle through 0,1,2,3)
next_state=$(((current_state + 1) % 4))
# Apply rotation
if [ -z "$MONITOR_NAME" ]; then
    # Apply to all monitors
    hyprctl keyword monitor ,transform,$next_state
else
    # Apply to specific monitor
    hyprctl keyword monitor $MONITOR_NAME,transform,$next_state
fi
# Save new state
echo "$next_state" > "$STATE_FILE"

# Optional: Show notification (requires dunst or similar)
case $next_state in
    0) notify-send "Screen Rotation" "Normal (0°)" -t 1000 2>/dev/null || echo "Rotated to: Normal (0°)" ;;
    1) notify-send "Screen Rotation" "90° Clockwise" -t 1000 2>/dev/null || echo "Rotated to: 90° Clockwise" ;;
    2) notify-send "Screen Rotation" "180°" -t 1000 2>/dev/null || echo "Rotated to: 180°" ;;
    3) notify-send "Screen Rotation" "270° Clockwise" -t 1000 2>/dev/null || echo "Rotated to: 270° Clockwise" ;;
esac
