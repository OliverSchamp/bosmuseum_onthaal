#!/bin/bash
# Variables
LOCAL_FILE="/home/dietpi/Desktop/bosmuseum_onthaal_tv.odp"
PYTHON_SCRIPT="/home/dietpi/bosmuseum_onthaal/projecten/automatisch_ppt/modify_presentation.py"

ODP_FILE=$LOCAL_FILE

# Check if the file exists
if [ ! -f "$ODP_FILE" ]; then
    echo "Error: File $ODP_FILE does not exist."
    exit 1
fi

# Check if the file is read-only (not writable) and make it writable
if [ ! -w "$ODP_FILE" ]; then
    echo "File $ODP_FILE is read-only. Attempting to make it writable..."
    chmod u+w "$ODP_FILE" 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: Failed to make $ODP_FILE writable. Check permissions or run with sudo."
        exit 1
    fi
    echo "Success: $ODP_FILE is now writable."
fi

# Check for lock file
LOCK_FILE="$(dirname "$ODP_FILE")/.~lock.$(basename "$ODP_FILE")#"
if [ -f "$LOCK_FILE" ]; then
    echo "Warning: Lock file $LOCK_FILE exists. Checking for conflicting LibreOffice process..."
    
    # Check if LibreOffice is holding the lock
    if pgrep -f "soffice" > /dev/null; then
        echo "LibreOffice is running. Attempting to close it to release the lock..."
        pkill -f "soffice" 2>/dev/null
        sleep 2  # Wait for process to terminate
        if pgrep -f "soffice" > /dev/null; then
            echo "Error: Failed to close LibreOffice. Please close it manually."
            exit 1
        fi
    fi

    # Remove the lock file if it still exists
    if [ -f "$LOCK_FILE" ]; then
        echo "Removing lock file $LOCK_FILE..."
        rm -f "$LOCK_FILE" 2>/dev/null
        if [ $? -ne 0 ]; then
            echo "Error: Failed to remove lock file. Check permissions."
            exit 1
        fi
    fi
    echo "Success: Lock file removed."
fi

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
# sleep 20  # Increased wait time for stability

# Wait until the process is running
echo "Waiting for LibreOffice to start..."
while ! ps -p $LIBRE_PID > /dev/null; do
    sleep 1
done

# Optional: Check if the socket is ready (if using --accept)
while ! netstat -tuln | grep ":2002" > /dev/null; do
    sleep 1
done

# Modify the presentation
echo "Running Python script to modify presentation..."
python3 "$PYTHON_SCRIPT" "$LOCAL_FILE" || { echo "Modification failed"; kill "$LIBRE_PID"; exit 1; }

# Kill the specific headless instance
echo "Stopping LibreOffice headless instance..."
kill "$LIBRE_PID"
sleep 1  # Give it a moment to fully terminate

pkill -f libreoffice

sleep 1

# Open the modified presentation (run as current user, not sudo)
#echo "Opening the modified presentation..."
#libreoffice --impress --norestore --show "$LOCAL_FILE" &

sudo systemctl restart automatic_ppt

echo "Script completed."
