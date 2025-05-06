#!/bin/bash
set -e

# Verzeichnisse vorbereiten
mkdir -p /opt/flash-firefox/plugins

# Firefox 7 herunterladen und entpacken
cd /opt/flash-firefox
wget -q https://ftp.mozilla.org/pub/firefox/releases/7.0/linux-x86_64/en-US/firefox-7.0.tar.bz2
tar -xvjf firefox-7.0.tar.bz2
rm firefox-7.0.tar.bz2

# Flash Player 10 (libflashplayer.so) herunterladen
wget -q -O libflashplayer.so https://github.com/Michdo93/openHAB-Crestron-RoomView-Control/raw/refs/heads/main/libflashplayer.so

# Plugin in das Firefox-Verzeichnis kopieren
mv libflashplayer.so /opt/flash-firefox/firefox/plugins/

# Optional: Symlink setzen (wenn gewünscht)
ln -s /opt/flash-firefox/firefox/firefox /usr/local/bin/firefox7

echo "Installation abgeschlossen."
echo "Starte Firefox 7 mit: firefox7"
