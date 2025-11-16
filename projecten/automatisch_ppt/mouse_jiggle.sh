#!/bin/bash

export DISPLAY=:0
export XAUTHORITY=/home/dietpi/.Xauthority

while true; do
    xdotool key F15
    sleep 1800   # 30 minutes
done
