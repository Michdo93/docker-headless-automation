#!/usr/bin/env python3
from pyvirtualdisplay import Display
import pyautogui
import datetime
import os
import time
import subprocess

# Starte Xvfb über pyvirtualdisplay
display = Display(visible=0, size=(1024, 768))
display.start()

os.system("xauth generate :99 . trusted")

# Etwas GUI-haftes starten
subprocess.Popen(["xclock"])

# Optional: kurze Pause, damit Xvfb sauber starten kann
time.sleep(2)

# Screenshot-Verzeichnis
output_dir = os.path.expanduser("/app/screenshots")
os.makedirs(output_dir, exist_ok=True)

# Screenshot erstellen
timestamp = datetime.datetime.now().strftime("%Y%m%d_%H%M%S")
filename = os.path.join(output_dir, f"screenshot_{timestamp}.png")

# Bild vom (leeren) virtuellen Display machen
screenshot = pyautogui.screenshot()
screenshot.save(filename)

print(f"Screenshot gespeichert unter: {filename}")

# Display beenden
display.stop()
