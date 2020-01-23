#!/bin/bash

# Command used to launch docker
DOCKER_CMD="`which docker`"

# Where to store the backups
BACKUP_PATH=""

# Where to store the communication pipes
FIFO_PATH="/tmp/docker-things/fifo"

# The name of the docker image
PROJECT_NAME="firefox"

# Meta to set in the .desktop file
APP_GENERIC_NAME="Web Browser"
APP_CATEGORIES="GNOME;GTK;Network;WebBrowser;"
APP_MIME_TYPE="text/html;text/xml;application/xhtml+xml;application/xml;application/rss+xml;application/rdf+xml;image/gif;image/jpeg;image/png;x-scheme-handler/http;x-scheme-handler/https;x-scheme-handler/ftp;x-scheme-handler/chrome;video/webm;application/x-xpinstall;"
APP_PARAM="%u"

# BUILD ARGS
BUILD_ARGS=(
    )

# LAUNCH ARGS
RUN_ARGS=(
    -e DISPLAY=$DISPLAY
    -v /tmp/.X11-unix:/tmp/.X11-unix

    -v $XAUTHORITY:/tmp/.Xauthority
    -e XAUTHORITY=/tmp/.Xauthority

    --memory="6g"
    --cpu-shares=1024
    --shm-size 2g

    --privileged

    -v $(pwd)/data/cache:/home/$(whoami)/.cache
    -v $(pwd)/data/mozilla:/home/$(whoami)/.mozilla
    -v /home/$(whoami)/Downloads:/home/$(whoami)/Downloads

    -v $XDG_RUNTIME_DIR/pulse:$XDG_RUNTIME_DIR/pulse
    -e PULSE_SERVER=unix:$XDG_RUNTIME_DIR/pulse/native

    --rm
    -d
    )
