#!/bin/sh
# Author: @santanamobile
# Backup Script for Vigor 3300
ADDR3300="192.168.50.254 192.168.80.254 192.168.81.254"
DATA=$(date +"%Y%m%d")
TIME=$(date +"%H%M%S")
PORT="8080"
TIMESTAMP="${DATA}${TIME}"
USER3300="USERNAME"
PASS="PASSWORD"
BACKUPDIR="/backup/router/"
if [ ! -d ${BACKUPDIR} ]; then
        mkdir -p ${BACKUPDIR}
fi;
echo "--------------------------------------------------"
for IP in ${ADDR3300}; do
        URL="http://${IP}:${PORT}/cgi-bin/mainfunction.cgi?set=download_cli_configuration"
        ARQ="${BACKUPDIR}${TIMESTAMP}-vigor.${IP}.cfg"
        echo -n "Device ${IP}: "
        wget -q --user=${USER3300} --password=${PASS} -O ${ARQ} ${URL}
        echo "ok"
done;
echo "--------------------------------------------------"
