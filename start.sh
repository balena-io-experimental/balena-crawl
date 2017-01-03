#!/bin/bash

# Set device hostname
# https://docs.resin.io/runtime/runtime/#dbus-communication-with-hostos
DBUS_SYSTEM_BUS_ADDRESS=unix:path=/host_run/dbus/system_bus_socket \
  dbus-send \
  --system \
  --print-reply \
  --reply-timeout=2000 \
  --type=method_call \
  --dest=org.freedesktop.hostname1 \
  /org/freedesktop/hostname1 \
  org.freedesktop.hostname1.SetStaticHostname \
  string:"${HOSTNAME-crawl}" boolean:true

# Avahi advertise the server
avahi-publish -s "Dungeon Crawl Stone Soup server for $(hostname)" _http._tcp 80 "Dungeon Crawl Stone Soup"

# Start Crawl server
cd crawl/crawl-ref/source
python webserver/server.py
