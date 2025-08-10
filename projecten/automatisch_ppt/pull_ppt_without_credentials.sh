#!/bin/bash

# sudo systemctl stop automatic_ppt || true
LOGFILE="/home/dietpi/pull_ppt.log"
echo "$(date): Starting script" >> $LOGFILE


#REFRESH_TOKEN=1//0...PUJzN0
FILE_ID=1SF....1U
#CLIENT_ID=401...tlrmhu.apps.googleusercontent.com
#CLIENT_SECRET=GOCS...dhnQ

#ACCESS_TOKEN=$(curl -s -X POST -d "client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&refresh_token=$REFRESH_TOKEN&grant_type=refresh_token" https://oauth2.googleapis.com/token | jq -r '.access_token')

#if [ -z "$ACCESS_TOKEN" ]; then
    #echo "$(date): Failed to obtain access token" >> $LOGFILE
    #exit 1
#fi

#curl -L -H "Authorization: Bearer $ACCESS_TOKEN" "https://docs.google.com/presentation/d/$FILE_ID/export/odp" -o /home/dietpi/Desktop/bosmuseum_onthaal_tv.odp
#curl -L -H "Authorization: Bearer $ACCESS_TOKEN" "https://docs.google.com/presentation/d/$FILE_ID/export/odp" -o /home/dietpi/Desktop/bosmuseum_onthaal_tv.odp --fail --show-error --retry 3 --retry-delay 5
curl -L "https://docs.google.com/presentation/d/$FILE_ID/export/odp" -o /home/dietpi/Desktop/bosmuseum_onthaal_tv.odp --fail --show-error --retry 3 --retry-delay 5


if [ $? -eq 0 ]; then
    echo "$(date): Successfully pulled presentation" >> $LOGFILE
else
    echo "$(date): Failed to pull presentation" >> $LOGFILE
    exit 1
fi

echo "$(date): Script finished" >> /home/dietpi/pull_ppt.log
