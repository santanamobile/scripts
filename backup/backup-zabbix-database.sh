#!/bin/sh
DATE=$(date +"%Y%m%d")
TIME=$(date +"%H%M")
TIMESTAMP="${DATA}-${TIME}"
HOST="127.0.0.1"
USER="root"
PASS="pass"
BACKUPDIR="/backup/sgbd/"
DATABASE="zabbix"

ARQ="${BACKUPDIR}${TIMESTAMP}-${BD}.sql"

if [ ! -d ${BACKUPDIR} ]; then
        mkdir -p ${BACKUPDIR}
fi;

mysqldump -u ${USER} -p ${PASS} \
	--ignore-table=${DATABASE}.acknowledges \
	--ignore-table=${DATABASE}.alerts \
	--ignore-table=${DATABASE}.auditlog \
	--ignore-table=${DATABASE}.auditlog_details \
	--ignore-table=${DATABASE}.escalations \
	--ignore-table=${DATABASE}.events \
	--ignore-table=${DATABASE}.history \
	--ignore-table=${DATABASE}.history_log \
	--ignore-table=${DATABASE}.history_str \
	--ignore-table=${DATABASE}.history_str_sync \
	--ignore-table=${DATABASE}.history_sync \
	--ignore-table=${DATABASE}.history_text \
	--ignore-table=${DATABASE}.history_uint \
	--ignore-table=${DATABASE}.history_uint_sync \
	--ignore-table=${DATABASE}.trends \
	--ignore-table=${DATABASE}.trends_uint > ${ARQ}
