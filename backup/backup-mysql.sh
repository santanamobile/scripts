#!/bin/sh
#
# Author: @santanamobile
# Backup Script for MySQL/MariaDB
#

DATE=$(date +"%Y/%m/%d")
HOST=$(hostname)
LOCATION="/backup/${DATE}/${HOST}/databases"
USER="rootuser"
PASS="rootpass"
DUMP_PARAMS="--add-drop-database --add-drop-table --complete-insert --single-transaction --lock-tables"
DATABASES="database1 database2 database3"

if [ ! -d ${LOCATION} ]; then
        mkdir -p ${LOCATION} 
        echo "Criando diretorio: ${LOCATION}"
fi;

echo "--------------------------------------------------"
for DATABASE in ${DATABASES}; do
	FILE="${LOCATION}/${DATABASE}.sql"
	echo -n "Database ${DATABASE}: "
        mysqldump -u ${USER} -p${PASS} ${DUMP_PARAMS} --databases ${DATABASE} > ${FILE}
	echo "ok"
done;

echo "--------------------------------------------------"
for DATABASE in ${DATABASES}; do
	FILE="${LOCATION}/${DATABASE}.sql"
	echo -n "Packing ${DATABASE}: "
        bzip2 ${ARQ}
#       p7zip ${ARQ}
#       gzip ${ARQ}
        echo "ok"   
done;
echo "--------------------------------------------------"
