#!/bin/bash

: "${SECRETMAN_DATA:=$HOME/.local/share/secretman/db}"

: "${SECRETMAN_BACKUPS:=$SECRETMAN_DATA/../backups}"

: "${SECRETMAN_CONFIG:=$HOME/.config/secretman/config.sh}"

if [ -f "$SECRETMAN_CONFIG" ]
then
  source "$SECRETMAN_CONFIG"
fi
