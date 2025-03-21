#!/bin/bash

# Ensure dependencies are installed
for cmd in wget curl jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Installing $cmd..."
        sudo apt update
        sudo apt install -y "$cmd"
    fi
done

# Define the target font directory
FONT_DIR="/usr/share/fonts/truetype/google-fonts"
echo "Creating the $FONT_DIR folder if it doesn't exist..."
sudo mkdir -p "$FONT_DIR"

# Temporary working directory
TEMP_DIR="/tmp/google-fonts-install"
mkdir -p "$TEMP_DIR"
cd "$TEMP_DIR" || exit 1

# List of font families (directory names in lowercase)
FONTS=(
  "roboto"
  "opensans"
  "lato"
  "montserrat"
  "raleway"
  "poppins"
  "notosans"
  "amaranth"
)

# GitHub API base URL
API_BASE="https://api.github.com/repos/google/fonts/contents/ofl"

# Download all .ttf files for each font family
for FONT_NAME in "${FONTS[@]}"; do
  echo "Installing all .ttf files for $FONT_NAME..."
  
  # Fetch the directory contents via GitHub API
  curl -s "$API_BASE/$FONT_NAME" > "$FONT_NAME.json"
  
  # Extract download URLs for .ttf files
  mapfile -t TTF_URLS < <(jq -r '.[] | select(.name | endswith(".ttf")) | .download_url' "$FONT_NAME.json")
  
  if [ ${#TTF_URLS[@]} -eq 0 ]; then
    echo "Warning: No .ttf files found for $FONT_NAME"
  else
    # Download each .ttf file
    for URL in "${TTF_URLS[@]}"; do
      FILE_NAME=$(basename "$URL")
      wget -q "$URL" -O "$FILE_NAME"
      if [ -f "$FILE_NAME" ]; then
        sudo mv "$FILE_NAME" "$FONT_DIR/"
        echo "Installed $FILE_NAME"
      else
        echo "Error: Failed to download $FILE_NAME"
      fi
    done
  fi
  
  # Clean up JSON file
  rm -f "$FONT_NAME.json"
done

# Update font cache
echo "Updating the font cache..."
sudo fc-cache -fv

# Clean up temporary directory
cd /tmp || exit 1
rm -rf "$TEMP_DIR"

echo "Selected Google Fonts installed. You can now test LibreOffice Impress."
