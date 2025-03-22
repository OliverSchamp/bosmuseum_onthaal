#!/bin/bash

# sudo systemctl stop automatic_ppt || true

REFRESH_TOKEN=1/..._o
FILE_ID=1S...U
CLIENT_ID=39...ft.apps.googleusercontent.com
CLIENT_SECRET=GOCS...cG

ACCESS_TOKEN=$(curl -s -X POST -d "client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&refresh_token=$REFRESH_TOKEN&grant_type=refresh_token" https://oauth2.googleapis.com/token | jq -r '.access_token')

curl -L -H "Authorization: Bearer $ACCESS_TOKEN" "https://docs.google.com/presentation/d/$FILE_ID/export/odp" -o /home/dietpi/Desktop/bosmuseum_onthaal_tv.odp

