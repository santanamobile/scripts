#!/bin/sh
DATA=$(date +"%Y%m%d-%H%M")
HST=$(hostname)
DIR="/backup/config"
ARQ="${DIR}/${DATA}-${HST}"
LST="/etc /boot /lib/modules/`uname -r` /var/spool/cron/crontabs"

if [ ! -d ${DIR} ]; then
        mkdir -p ${DIR}
        echo "Criando diretorio: ${DIR}"
fi;

echo "--------------------------------------------"
echo ""
echo "Lista de arquivos: ${LST}"
echo "Arquivo de backup: ${ARQ}"
echo ""
echo "--------------------------------------------"
echo "Backup das configuracoes"
tar cfj ${ARQ}.tar.bz2 ${LST}
echo "--------------------------------------------"
