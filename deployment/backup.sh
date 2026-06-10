#!/bin/bash

TIMESTAMP=$(date +%Y%m%d%H%M%S)

cp -r /opt/sampleapp/app 
/opt/sampleapp/backups/app-$TIMESTAMP
