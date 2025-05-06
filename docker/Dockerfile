# Verwenden der Basis-Image für Ubuntu 20.04
FROM ubuntu:20.04

# Setze Umgebungsvariablen, um nicht-interaktive Installationen durchzuführen
ENV DEBIAN_FRONTEND=noninteractive

# Update und Installation grundlegender Pakete und Abhängigkeiten
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    python3-tk \
    python3-xlib \
    tesseract-ocr \
    gnome-screenshot \
    nano \
    curl \
    unzip \
    xvfb \
    xorg \
    openbox \
    imagemagick \
    xserver-xephyr \
    cron \
    xauth \
    x11-utils \
    dbus-x11 \
    libssl-dev \
    poppler-utils \
    scrot \
    libxss1 \
    libappindicator3-1 \
    libindicator7 \
    && apt-get clean

RUN touch /root/.Xauthority
RUN Xvfb :99 -screen 0 1024x768x16 &
ENV DISPLAY=:99

# Installiere Google Chrome (für Web-Scraping und Automation)
RUN curl https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o /chrome.deb
RUN dpkg -i /chrome.deb || apt-get install -yf
RUN rm /chrome.deb

# Installiere ChromeDriver
RUN curl -L https://storage.googleapis.com/chrome-for-testing-public/136.0.7103.49/linux64/chromedriver-linux64.zip -o /usr/local/bin/chromedriver.zip \
 && unzip /usr/local/bin/chromedriver.zip -d /usr/local/bin/ \
 && cp /usr/local/bin/chromedriver-linux64/chromedriver /usr/local/bin/ \
 && chmod +x /usr/local/bin/chromedriver \
 && rm -rf /usr/local/bin/chromedriver.zip /usr/local/bin/chromedriver-linux64

# Chromedriver-Verzeichnis in den PATH aufnehmen
ENV PATH="/usr/local/bin:$PATH"

# Erstelle ein Arbeitsverzeichnis für das Python-Projekt
RUN mkdir /app
WORKDIR /app

# Kopiere die requirements.txt ins Arbeitsverzeichnis und installiere die Python-Abhängigkeiten
COPY requirements.txt /app
RUN pip3 install -r requirements.txt

# Installiere PyAutoGUI und pyvirtualdisplay (für Headless-Betrieb)
RUN pip3 install pyautogui pyvirtualdisplay

# Erstelle das Start-Skript
COPY start.sh /opt/start.sh
RUN chmod +x /opt/start.sh

# Default-Command: Start-Skript ausführen, um Cronjobs zu starten und PyAutoGUI auszuführen
ENTRYPOINT ["/opt/start.sh"]
