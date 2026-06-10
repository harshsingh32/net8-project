#!/bin/bash

APP_DIR=/opt/sampleapp/app

BACKUP_DIR=/opt/sampleapp/backups

LATEST_BACKUP=$(ls -dt $BACKUP_DIR/app-* | head -1)

if [ -z "$LATEST_BACKUP" ]
then
    echo "No Backup Found"
    exit 1
fi

rm -rf $APP_DIR/*

cp -r $LATEST_BACKUP/* $APP_DIR/

docker restart sampleapp