#!/bin/bash

# define color
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

mkdir -p output/

#################################################
# PACKAGE DUMP
#################################################

#################################################
# PROCESS DUMP
#################################################

echo

#################################################
# SERVICES DUMP
#################################################

if [ -x "$(command -v systemctl)" ]; then
    echo "[-] System is using systemd"
    systemctl list-units --type=service > output/services_systemctl
elif [ -x "$(command -v initctl)" ]; then
    echo "[-] System is using Upstart"
    initctl list >output/services_upstart
else
    echo "${RED}[!] System is using a different init system{$NC}"
fi

#################################################
# ARP TABLE DUMP
#################################################

#################################################
# SSH KEYS DUMP
#################################################

#################################################
# /etc/passwd backup
#################################################
