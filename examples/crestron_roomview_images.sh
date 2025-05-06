#!/bin/bash
set -e

# Zielpfad
DEST_DIR="/app/openHAB-Crestron-RoomView-Control/images"

# Temporäres Verzeichnis zum Klonen
TMP_DIR="/tmp/crestron_repo"

# Benötigtes Paket installieren (falls nicht vorhanden)
if ! command -v git &> /dev/null; then
    echo "git nicht gefunden. Installiere..."
    apt-get update && apt-get install -y git
fi

# Repository klonen
git clone https://github.com/Michdo93/openHAB-Crestron-RoomView-Control.git "$TMP_DIR"

# Zielverzeichnis erstellen und images verschieben
mkdir -p "$(dirname "$DEST_DIR")"
mv "$TMP_DIR/images" "$DEST_DIR"

# Geklonte Daten löschen
rm -rf "$TMP_DIR"

echo "Images-Verzeichnis wurde erfolgreich nach $DEST_DIR verschoben und der Rest gelöscht."
