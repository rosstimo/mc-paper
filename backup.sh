#!/bin/bash"
TIME_STAMP="$(date '+%Y-%m-%d_%H:%M:%S')"
PRODUCTION_PATH="/minecraft/production"
BACKUP_DIR="/minecraft/backups"
BACKUP_PATH="${BACKUP_DIR}/${TIME_STAMP}"
mkdir "${BACKUP_PATH}"
rsync -varn \
    --log-file="${BACKUP_DIR}/backup.log" \
     "{PRODUCTION_PATH}" \
    #--exclude="" \
    "${BACKUP_PATH}"
