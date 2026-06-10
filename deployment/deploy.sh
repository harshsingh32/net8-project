#!/bin/bash

set -e

ZIPFILE=$1

BUILD_NUMBER=$2

JOB_NAME=$3

APP_DIR=/opt/sampleapp/app

LOGFILE=/opt/sampleapp/logs/deploy.log

DATE=$(date)

echo "[$DATE]" >> $LOGFILE
echo "Deploying Build $BUILD_NUMBER" >> $LOGFILE

docker stop sampleapp

rm -rf ${APP_DIR}/*

unzip -o $ZIPFILE -d $APP_DIR

docker start sampleapp

sleep 10

curl -f http://localhost

echo "Deployment Successful" >> $LOGFILE
