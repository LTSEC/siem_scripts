#!/bin/bash

# define color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# define run
printf "run name:\t"
read RUN_NAME

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

mkdir -p output/

#################################################
# CRONTAB DUMP
#################################################

for user in $(cut -f1 -d: /etc/passwd); do
    # Check if the user has a crontab file
    crontab_file=$(sudo crontab -l -u $user 2>/dev/null)
    if [ ! -z "$crontab_file" ]; then
        echo "[-] Crontab for user $user:"
        echo "${BLUE}$crontab_file${NC}"
        echo "============================="
    fi
done

#################################################
# PACKAGE DUMP
#################################################

#Update and Upgrade system
# if [[ "$option" = "6" ]]; then
    ID_LIKE="$(cat /etc/*release | grep "ID_LIKE")"
    # printf '\nDid you audit the source files first? (Y/N)\n'
    # read -r option

    # if [[ -z "$option" ]]; then
    # 	printf '\nInvalid option\n'
    # fi

    # if [[ "$option" = "Y"  ]] || [[ "$option" = "y" ]]; then
    if [[ ${ID_LIKE} = "ID_LIKE=rhel fedora" ]] || [[ ${ID_LIKE} = "ID_LIKE=\"rhel fedora\"" ]]; then
        yum update && yum upgrade
    fi

    if [[ ${ID_LIKE} = "ID_LIKE=arch" ]] || [[ ${ID_LIKE} = "ID_LIKE=\"arch\"" ]]; then
        pacman -Syu
    fi

    if [[ ${ID_LIKE} = "ID_LIKE=debian" ]] || [[ ${ID_LIKE} = "ID_LIKE=\"debian\"" ]]; then
        apt-get update && apt-get upgrade
    fi

    # fi

    # if [[ "$option" = "N" ]] || [[ "$option" = "n" ]]; then
    #     printf '\nThen what are you waiting for!!\n'
    # fi
# fi

#################################################
# PROCESS DUMP
#################################################

ps -aux >output/processes_$RUN_NAME

#################################################
# SERVICES DUMP
#################################################

if [ -x "$(command -v systemctl)" ]; then
    echo "[-] System is using systemd"
    systemctl list-units --type=service >output/services_systemctl_$RUN_NAME
elif [ -x "$(command -v initctl)" ]; then
    echo "[-] System is using Upstart"
    initctl list >output/services_upstart_$RUN_NAME
else
    echo "${RED}[!] System is using a different init system{$NC}"
fi

#################################################
# PORT DUMP
#################################################

# file which contains services registered with the system
cp /etc/services output/etc_services_$RUN_NAME

if [ -x "$(command -v netstat)" ]; then
    echo "[-] System has netstat - recording ports"
    netstat -tulpn | grep LISTEN >output/ports_netstat_$RUN_NAME
else
    echo "${RED}[!] System does not have netstat{$NC}"
fi

if [ -x "$(command -v ss)" ]; then
    echo "[-] System has ss - recording ports"
    ss -tulpn | grep LISTEN >output/ports_ss_$RUN_NAME
else
    echo "${RED}[!] System does not have ss{$NC}"
fi

if [ -x "$(command -v lsof)" ]; then
    echo "[-] System has lsof - recording ports"
    lsof -i -P -n | grep LISTEN >output/ports_lsof_$RUN_NAME
else
    echo "${RED}[!] System does not have lsof{$NC}"
fi

#################################################
# ARP TABLE DUMP
#################################################

if [ -x "$(command -v arp)" ]; then
    echo "[-] dumping arp table"
    arp >output/arp_table_$RUN_NAME
else
    echo "${RED}[!] System does not have arp installed{$NC}"
fi

#################################################
# SSH KEYS DUMP
#################################################

#################################################
# important file backup backup
#################################################

IMPORTANT_FILES=(
    "/etc/passwd" "/etc/shadow" "/etc/group" "/etc/sudoers"
)

for important_file in "${IMPORTANT_FILES[@]}"; do
    cp ${important_file} ${important_file}.bak_$RUN_NAME
    if [ $? -ne 0 ]; then
        echo "${RED}[!] did not back up ${important_file} succesfully {$NC}"
    else
        echo "[-] backed up ${important_file}"
    fi
done

#################################################
# IMPORTANT DIRECTORY BACKUP
#################################################

mkdir -p /var/backups

cp -r /etc/pam* /var/backups
cp -r /lib/security* /var/backups

if [ -d "/var/www" ]; then
    echo "[-] Backing up web files"
    cp -r /var/www /var/backups
fi

if [ -d "/var/lib/mysql" ]; then
    echo "[-] Backing up MySQL"
    mysqldump -u root -p --all-databases >/var/backups/mysql.sql
fi
chattr +i -R /var/backups/*

### TODO add
https://github.com/ucrcyber/CCDC/blob/master/blue-team/linux/disableMod.sh
