#!/bin/bash

# Variables
SOURCE_URL="https://your.google.docs.url/presentation.odp"  # Replace with your Google Docs download URL
LOCAL_FILE="/home/user/presentation.odp"  # Destination path
PYTHON_SCRIPT="/home/user/modify_presentation.py"  # Path to Python script

# Download the presentation from Google Docs
wget -O "$LOCAL_FILE" "$SOURCE_URL" || { echo "Download failed"; exit 1; }

# Start LibreOffice in the background with a listener for UNO API
libreoffice --headless --accept="socket,host=localhost,port=2002;urp;" &

# Wait briefly for LibreOffice to start
sleep 5

# Modify the presentation using the Python script
python3 "$PYTHON_SCRIPT" "$LOCAL_FILE" || { echo "Modification failed"; exit 1; }

# Kill the headless LibreOffice instance
pkill -f "libreoffice --headless"

# Play the modified presentation
libreoffice --impress --show "$LOCAL_FILE"
