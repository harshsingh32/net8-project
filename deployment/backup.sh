#!/bin/bash

BACKUP_DIR=/opt/sampleapp/backups
APP_DIR=/opt/sampleapp/app

TIMESTAMP=$(date +%Y%m%d%H%M%S)

mkdir -p $BACKUP_DIR

BACKUP_PATH=$BACKUP_DIR/app-$TIMESTAMP

cp -r $APP_DIR $BACKUP_PATH

echo $BACKUP_PATH

ls -dt $BACKUP_DIR/app-* \
2>/dev/null \
| tail -n +8 \
| xargs rm -rf 2>/dev/null