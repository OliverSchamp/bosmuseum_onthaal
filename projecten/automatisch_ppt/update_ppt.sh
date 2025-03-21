#!/bin/bash

# Variables
LOCAL_FILE="/home/dietpi/Desktop/bosmuseum_onthaal_tv.odp"  # Destination path
PYTHON_SCRIPT="/home/dietpi/bosmuseum_onthaal/projecten/automatisch_ppt/modify_presentation.py"  # Path to Python script

# Start LibreOffice in the background with a listener for UNO API
libreoffice --headless --accept="socket,host=localhost,port=2002;urp;" &

# Wait briefly for LibreOffice to start
sleep 2

# Modify the presentation using the Python script
python3 "$PYTHON_SCRIPT" "$LOCAL_FILE" || { echo "Modification failed"; exit 1; }

# Kill the headless LibreOffice instance
pkill -f "libreoffice --headless"

# Play the modified presentation
# libreoffice --impress --norestore --show "$LOCAL_FILE"
