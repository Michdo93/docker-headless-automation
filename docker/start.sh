#!/bin/bash

touch /root/.Xauthority

# Virtuelles Display starten
Xvfb :99 -screen 0 1024x768x16 &
sleep 2
export DISPLAY=:99

# Warte kurz, bis Xvfb läuft
sleep 2

# Crontab laden, wenn vorhanden
CRON_FILE="/app/crontab.txt"
if [ -f "$CRON_FILE" ]; then
  crontab "$CRON_FILE"
else
  echo "* * * * * DISPLAY=:99 /usr/bin/python3 /app/script.py >> /app/cron.log 2>&1" | crontab -
fi

# Starte Cron und gib Logs aus
cron
touch /app/cron.log
tail -F /app/cron.log
