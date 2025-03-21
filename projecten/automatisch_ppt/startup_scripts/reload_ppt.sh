#!/bin/bash

# Stop the other systemd service
systemctl stop other-service-name.service

# Download Google Doc as .odp (using gdown or curl, assuming it’s shared publicly)
# Replace <GOOGLE_DOC_ID> with the document’s ID from its URL
curl -L "https://docs.google.com/presentation/d/1SFXI0UF8THcG3g4cFXVp4qHPm1jvYCEhnPvqYpXr81U/export/odp" -o /path/to/output_file.odp

# Restart the other service
systemctl start other-service-name.service
