#!/usr/bin/env python3
from pyvirtualdisplay import Display
import pyautogui
import datetime
import os
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service

# Starte Xvfb über pyvirtualdisplay
display = Display(visible=0, size=(1024, 768))
display.start()

os.system("xauth generate :99 . trusted")

# Chrome-Optionen vorbereiten
chrome_options = Options()
chrome_options.add_argument("--no-sandbox")
chrome_options.add_argument("--disable-dev-shm-usage")
chrome_options.add_argument("--window-size=1024,768")

service = Service(executable_path="/usr/local/bin/chromedriver")

# Browser starten
driver = webdriver.Chrome(service=service, options=chrome_options)

# Webseite aufrufen
driver.get("https://www.google.de")

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
driver.quit()
display.stop()
