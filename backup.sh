#!/bin/bash
TIME_STAMP="$(date '+%Y-%m-%d_%H:%M:%S')"
SOURCE_PATH="/minecraft"
BACKUP_DIR="/minecraft/backups"
BACKUP_PATH="${BACKUP_DIR}/${TIME_STAMP}"

if [ ! -d "${BACKUP_DIR}" ]; then
    mkdir "${BACKUP_DIR}"
    wait $!
fi

mkdir "${BACKUP_PATH}"

rsync -varc \
    --log-file="${BACKUP_DIR}/backup.log" \
     "${SOURCE_PATH}" \
    --exclude="/backups/*" \
    "${BACKUP_PATH}"
