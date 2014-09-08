#!/bin/sh
# Author: @santanamobile
# Backup Script for Vigor 2910
ADDR2910="192.168.0.254 192.168.90.254 192.168.91.254"
DATA=$(date +"%Y%m%d")
TIME=$(date +"%H%M%S")
PORT="8080"
TIMESTAMP="${DATA}${TIME}"
USER2910="USERNAME"
PASS="PASSWORD"
BACKUPDIR="/backup/router/"

if [ ! -d ${BACKUPDIR} ]; then
        mkdir -p ${BACKUPDIR}
fi;
echo "--------------------------------------------------"
for IP in ${ADDR2910}; do
        URL="http://${IP}:${PORT}/V2910_${DATA}.cfg"
        ARQ="${BACKUPDIR}${TIMESTAMP}-vigor.${IP}.cfg"
        echo -n "Device ${IP}: "
        wget -q --user=${USER2910} --password=${PASS} -O ${ARQ} ${URL}
        echo "ok"
done;
echo "--------------------------------------------------"
