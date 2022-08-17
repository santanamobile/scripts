#!/bin/sh
#
# Author: @santanamobile
# Backup Script for Zabbix database
#

DATE=$(date +"%Y/%m/%d")
HOST=$(hostname)
LOCATION="/backup/${DATE}/${HOST}/databases"
USER="rootuser"
PASS="rootpass"
DUMP_PARAMS="--add-drop-database --add-drop-table --complete-insert --single-transaction --lock-tables --default-character-set=utf8mb4 "
DATABASES="zabbix"

if [ ! -d ${LOCATION} ]; then
        mkdir -p ${LOCATION}
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
	bzip2 ${FILE}
	echo "ok"
done;
echo "--------------------------------------------------"
