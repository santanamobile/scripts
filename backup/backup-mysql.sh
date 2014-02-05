#!/bin/sh
# Author: @santanamobile
# Backup Script for MySQL
SGBD="database1 database2 database3"
DATE=`date +"%Y%m%d"`
TIME=`date +"%H%M"`  
TIMESTAMP="${DATE}-${TIME}"
HOST="localhost"
USER="rootuser"
PASS="rootpass"
BACKUPDIR="/backup/sgbd/"

if [ ! -d ${BACKUPDIR} ]; then
        mkdir -p ${BACKUPDIR} 
fi;

echo "--------------------------------------------------"
for BD in ${SGBD}; do
        ARQ="${BACKUPDIR}${TIMESTAMP}-${BD}.sql"
        echo -n "Database ${BD}: "
        mysqldump -u ${USER} -h ${HOST} -p${PASS} ${BD} > ${ARQ}
        echo "ok"
done;

echo "--------------------------------------------------"
for BD in ${SGBD}; do
        ARQ="${BACKUPDIR}${TIMESTAMP}-${BD}.sql"
        echo -n "Compressing ${BD}: "
        bzip2 ${ARQ}
#       p7zip ${ARQ}
#       gzip ${ARQ}
        echo "ok"   
done;
echo "--------------------------------------------------"
