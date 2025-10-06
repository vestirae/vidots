#!/bin/bash
# Check if rofi is running
if pgrep -x "rofi" > /dev/null; then
    # Kill rofi if running
    pkill -x "rofi"
else
    # Launch rofi (modify this line if you want a specific mode or config)
    rofi -show drun &
fi
