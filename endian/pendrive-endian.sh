#!/bin/sh
URL="http://ufpr.dl.sourceforge.net/project/efw/Development/EFW-3.0.5-beta1/"
ISO="EFW-COMMUNITY-3.0.5-beta1-devel-201504071248.iso"
# Comente a linha a baixo se nao precisar de realizar o download do ISO
wget -t0 -c ${URL} -v -O ${ISO}

if [ "$(id -u)" != "0" ]; then
	clear
	echo "#########################################################"
	echo "#                                                       #"
	echo "# Execute este script com 'sudo' ou como root           #"
	echo "# Ex: sudo ./pendrive-endian <drive>                    #"
	echo "#                                                       #"
	echo "#########################################################"
	exit 1
fi

if [ -z "$1" ]; then
	clear
	echo "#########################################################"
	echo "#                                                       #"
	echo "# Informe o disco removivel de destino:                 #"
	echo "# Ex: sudo ./pendrive-endian /dev/sdb                   #"
	echo "#                                                       #"
	echo "#########################################################"
	echo
	exit 1
fi

DISK="$1"
PART="${DISK}1"

clear
echo "#########################################################"
echo "#                                                       #"
echo "#            ENDIAN COMMUNITY USB Installer             #"
echo "#                                                       #"
echo "#########################################################"
echo "#                                                       #"
echo "# Esta aplicacao vai excluir definitivamente qualquer   #"
echo "# informacao da unidade escolhida, verifique atentamente#"
echo "#                                                       #"
echo "#########################################################"
echo

echo "Verificando ferramentas necessarias para criacao do pendrive"

echo -n "parted: "
which parted > /dev/null
if [ "$?" = "1" ]; then
	echo "falha"
	echo "Instale com o comando:"
	echo "apt-get install parted"
	exit 1
fi
echo "ok"

echo -n "mkfs.vfat: "
which mkfs.vfat > /dev/null
if [ "$?" = "1" ]; then
	echo "falha"
	exit 1
fi
echo "ok"

echo -n "partprobe: "
which partprobe > /dev/null
if [ "$?" = "1" ]; then
	echo "falha"
	exit 1
fi
echo "ok"

echo -n "syslinux: "
which syslinux > /dev/null
if [ "$?" = "1" ]; then
	echo "falha"
	echo "Instale com o comando:"
	echo "apt-get install syslinux"
	exit 1
fi
echo "ok"

MNTISO=$(mktemp -d)
MNTEFW=$(mktemp -d)

umount ${DISK}*
parted -s "$DISK" mklabel msdos

echo "Criando particoes em: ${DISK}"
parted -s "$DISK" mkpart primary 0 1000

echo "Ativando particao..."
parted -s "$DISK" set 1 boot on

echo "Atualizado tabela de particoes..."
partprobe "$DISK"

echo "Criando sistema de arquivos em ${PART1}"
mkfs.vfat "$PART" -I -n ENDIAN
# mkfs.vfat -n endian -F 32 ${PART}

echo "Montando imagem de CD-ROM: ${ISO}"
mount -o loop ${ISO} ${MNTISO}

echo "Montando pendrive ${PART} ..."
mount ${PART} ${MNTEFW}
##########
# FIXME!!!
# MNTINIT=$(mktemp -d)
# gunzip instroot.gz
# mount -o loop instroot  ${MNTINIT}
# editar/alterar - ${MNTINIT}/bin/mountsource.sh
# umount ${MNTINIT}
# rm -rf ${MNTINIT}
# gzip -9 instroot
# Fim de FIXME!!!
##########
echo "Copiando arquivos para midia removivel."
cp -a ${MNTISO}/* ${MNTEFW}

echo "Criando configuracao de boot"
cd ${MNTEFW}
mv boot/isolinux/* ./
rm -rf boot
mv isolinux.bin syslinux.bin
mv isolinux.cfg syslinux.cfg

cd ~
umount ${MNTISO}
umount ${MNTEFW}

rm -rf ${MNTISO}
rm -rf ${MNTEFW}

echo "Ativando inicializacao em: ${DISK}"
syslinux ${PART}

echo "Instalacao completa."
