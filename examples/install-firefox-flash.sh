#!/bin/bash
set -e

# Arbeitsverzeichnis vorbereiten
mkdir -p /opt/flash-firefox
cd /opt/flash-firefox

# Firefox 7 herunterladen und entpacken
echo "Lade Firefox 7 herunter..."
wget -q https://ftp.mozilla.org/pub/firefox/releases/7.0/linux-x86_64/en-US/firefox-7.0.tar.bz2
tar -xjf firefox-7.0.tar.bz2
rm firefox-7.0.tar.bz2

# Plugin-Verzeichnis im Firefox-Ordner erstellen
mkdir -p /opt/flash-firefox/firefox/plugins

# Flash Player 10 (libflashplayer.so) herunterladen
echo "Lade Flash Player herunter..."
wget -q -O libflashplayer.so https://github.com/Michdo93/openHAB-Crestron-RoomView-Control/raw/refs/heads/main/libflashplayer.so

# Plugin in das Firefox-Verzeichnis kopieren
mv libflashplayer.so /opt/flash-firefox/firefox/plugins/

# Optional: Symlink setzen
ln -sf /opt/flash-firefox/firefox/firefox /usr/local/bin/firefox7

echo "Installation abgeschlossen."
echo "Starte Firefox 7 mit: firefox7"
