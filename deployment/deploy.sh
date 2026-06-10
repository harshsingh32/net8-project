#!/bin/bash

set -e

ZIPFILE=$1
BUILD_NUMBER=$2
JOB_NAME=$3

APP_DIR=/opt/sampleapp/app
LOG_DIR=/opt/sampleapp/logs

mkdir -p $LOG_DIR

LOGFILE=$LOG_DIR/deploy.log

DATE=$(date '+%Y-%m-%d %H:%M:%S')

log() {
    echo "$1" >> $LOGFILE
}

log "=================================="
log "[$DATE]"
log "Build: #$BUILD_NUMBER"
log "Job: $JOB_NAME"

if [ ! -f "$ZIPFILE" ]
then
    log "Status: FAILED"
    log "Failure Reason: ZIP Package Missing"
    exit 1
fi

BACKUP_PATH=$(
/opt/sampleapp/scripts/backup.sh
)

log "Backup Created: $BACKUP_PATH"

docker stop sampleapp

rm -rf $APP_DIR/*

unzip -o $ZIPFILE \
-d $APP_DIR >> $LOGFILE 2>&1

docker start sampleapp

sleep 10

if /opt/sampleapp/scripts/healthcheck.sh
then

    log "Status: SUCCESS"
    log "Application Restarted Successfully"

    exit 0

else

    log "Status: FAILED"
    log "Failure Reason: Health Check Failed"

    log "Rollback Started"

    /opt/sampleapp/scripts/rollback.sh

    sleep 10

    if /opt/sampleapp/scripts/healthcheck.sh
    then
        log "Rollback Status: SUCCESS"
    else
        log "Rollback Status: FAILED"
    fi

    exit 1
fi