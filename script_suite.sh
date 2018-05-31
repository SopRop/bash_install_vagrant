#!/usr/bin/env bash

# Variables couleurs

TXT='\033[0;36m'
QST='\033[1;35m'
END='\033[1;33m'
NC='\033[0m'

# Installation Apache

echo -e "${QST}Veux-tu installer le serveur Apache ? (O/N) ${NC}"
read apache

    case "$apache" in
      o|O ) echo -e "${TXT}Installation... ${NC}"
      sleep 1
      sudo apt-get -y install apache2
      echo -e "${TXT}Installation terminée ${NC}"
      sleep 1;;
      n|N ) echo -e "${TXT}D'acc. ${NC}";;
      * ) echo -e "${TXT}Je n'ai pas compris ${NC}"
      read apache;;
    esac

# Installation Python

echo -e "${QST}Veux-tu installer Python ? (O/N) ${NC}"
read python

    case "$python" in
      o|O ) echo -e "${TXT}Installation... ${NC}"
      sleep 1
      sudo apt-get install python3
      echo -e "${TXT}Installation terminée ${NC}"
      sleep 1;;
      n|N ) echo -e "${TXT}Oh ? ${NC}";;
      * ) echo -e "${TXT}Je n'ai pas compris ${NC}"
      read python;;
    esac

# THE END

sleep 1
echo
echo -e "${END}See ya ;) ${NC}"