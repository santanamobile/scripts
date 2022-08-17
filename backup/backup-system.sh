#!/bin/sh
#
# Author: @santanamobile
# Backup Script for Linux System
#

DATE=$(date +"%Y/%m/%d")
HOST=$(hostname)
LOCATION="/backup/${DATE}/${HOST}"
ARQ="${LOCATION}/system"
FILES="/etc /boot /lib/modules/`uname -r` /var/spool/cron/crontabs"

if [ ! -d ${LOCATION} ]; then
        mkdir -p ${LOCATION}
        echo "Criando diretorio: ${LOCATION}"
fi;

echo "--------------------------------------------"
echo ""
echo "Lista de arquivos: ${FILES}"
echo "Arquivo de backup: ${ARQ}.tar.bz2"
echo ""
echo "--------------------------------------------"
echo "Backup das configuracoes"
tar cfj ${ARQ}.tar.bz2 ${FILES}
echo "--------------------------------------------"
