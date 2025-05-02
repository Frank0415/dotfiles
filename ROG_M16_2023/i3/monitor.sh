#!/bin/bash

# Check if DP-2 is connected
if xrandr | grep -q "DP-2 connected"; then
    # If DP-2 exists, configure HDMI-2 with specific options
    xrandr --output DP-2 --auto --right-of eDP-1 --scale 0.8
else
    # If DP-2 does not exist, do nothing
    echo "DP-2 not connected, skipping HDMI-2 configuration."
fi
 