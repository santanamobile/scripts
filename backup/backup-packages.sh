#!/bin/sh
#
# Author: @santanamobile
# Backup Script for system packages
#

DATE=$(date +"%Y/%m/%d")
HOST=$(hostname)
LOCATION="/backup/${DATE}/${HOST}/packages"

if [ ! -d ${LOCATION} ]; then
        mkdir -p ${LOCATION};
fi;

dpkg --get-selections > ${LOCATION}/package.list
cp -R /etc/apt/sources.list* ${LOCATION}
apt-key exportall > ${LOCATION}/repo.keys
