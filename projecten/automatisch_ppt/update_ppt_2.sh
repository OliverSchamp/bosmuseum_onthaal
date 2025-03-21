#!/bin/bash

# Variables
LOCAL_FILE="/home/dietpi/Desktop/bosmuseum_onthaal_tv.odp"
PYTHON_SCRIPT="/home/dietpi/bosmuseum_onthaal/projecten/automatisch_ppt/modify_presentation.py"

# Check if LibreOffice is already running on port 2002
if netstat -tuln | grep -q ":2002"; then
    echo "Killing existing LibreOffice instance on port 2002..."
    pkill -f "libreoffice --headless"
    sleep 1
fi

# Start LibreOffice in headless mode with UNO listener
echo "Starting LibreOffice in headless mode..."
libreoffice --headless --accept="socket,host=localhost,port=2002;urp;" --nolockcheck &

# Capture the PID of the headless instance
LIBRE_PID=$!
sleep 5  # Increased wait time for stability

# Modify the presentation
echo "Running Python script to modify presentation..."
python3 "$PYTHON_SCRIPT" "$LOCAL_FILE" || { echo "Modification failed"; kill "$LIBRE_PID"; exit 1; }

# Kill the specific headless instance
echo "Stopping LibreOffice headless instance..."
kill "$LIBRE_PID"
sleep 1  # Give it a moment to fully terminate

pkill -f libreoffice

sleep 5

# Open the modified presentation (run as current user, not sudo)
echo "Opening the modified presentation..."
libreoffice --impress --norestore --show "$LOCAL_FILE" &

echo "Script completed."
