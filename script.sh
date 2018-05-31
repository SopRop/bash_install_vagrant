#!/usr/bin/env bash

# Variables couleurs

TXT='\033[0;36m'
QST='\033[1;35m'
NC='\033[0m'

echo -e "${TXT}Hello, je vais t'assister pour créer une machine virtuelle. ${NC}"

# Demande installation VM

echo -e "${QST}As-tu déjà installé VirtualBox ? (O/N) ${NC}"
read answer

case "$answer" in
  o|O ) echo -e "${TXT}Parfait ! ${NC}"
  sleep 1;;
  n|N ) echo -e "${TXT}Oh, oh... Peux-tu le faire, stp ? ${NC}"
  exit;;
  * ) echo -e "${TXT}Je n'ai pas compris ${NC}"
  read answer;;
esac


# Demande installation Vagrant

echo -e "${QST}As-tu déjà installé Vagrant ? (O/N) ${NC}"
read answer

case "$answer" in
  o|O ) echo -e "${TXT}Parfait, tout est en place ! ${NC}"
  sleep 1;;
  n|N ) echo -e "${TXT}Oh, oh... Peux-tu t'en charger, stp ? ${NC}"
  exit;;
  * ) echo -e "${TXT}Je n'ai pas compris ${NC}"
  read answer;;
esac

# Initialisation Vagrant

echo -e "${QST}Quel sera le nom du dossier contenant la Vagrant ? ${NC}"
read vagrant

mkdir $vagrant
cd $vagrant

echo -e "${TXT}Initialisation de la Vagrant ${NC}"
sleep 1
vagrant init
echo -e "${TXT}Initialisation terminée ${NC}"
sleep 1

# Personnalisation Vagrant

echo -e "${TXT}Il me faut quelques informations. ${NC}"
sleep 2

# Choix config Linux

echo -e "${QST}Quelle configuration Linux veux-tu ? ${NC}"
sleep 1
echo -e "${TXT}1 : ubuntu/xenial64-1 ${NC}"
echo -e "${TXT}2 : ubuntu/xenial64-2 ${NC}"
echo -e "${TXT}3 : ubuntu/xenial64-3 ${NC}"
echo -e "${TXT}4 : ubuntu/xenial64-4 ${NC}"
read linux

case "$linux" in
  1|2|3|4 ) echo -e "${TXT}C'est noté ! ${NC}"
            sleep 1;;
  * ) echo -e "${TXT}Je n'ai pas compris ${NC}"
      read answer;;
esac

sed -i '15s-base-ubuntu/xenial64-' Vagrantfile

# Choix dossier

echo -e "${QST}Quel sera le nom du dossier synchronisé ? ${NC}"
read dossier
mkdir $dossier

sed -i '46s-#--' Vagrantfile
sed -i '46s-../data-./'"${dossier}"'-' Vagrantfile
sed -i '46s-/vagrant_data-/var/www/html-' Vagrantfile

# Choix IP

echo -e "${QST}Quelle sera la fin de l'adresse IP (2 chiffres) ? ${NC}"
read ip

if [[ ${#ip} > 2 ]] || [[ -n ${ip//[0-9]/} ]]
then
    echo -e "${TXT}Entrée non conforme. ${NC}"
    read ip
else
    sed -i '35s-#--' Vagrantfile
    sed -i '35s-10-'"${ip}"'-' Vagrantfile
fi

# Installation

echo -e "${TXT}Merci, la première partie est terminée. ${NC}"
sleep 1
echo -e "${TXT}Lancement de l'installation... ${NC}"
sleep 1
echo

vagrant up

cp ../script_suite.sh ../$vagrant/$dossier

# Vagrant status

echo -e "${QST}Besoin d'avoir la liste de toutes tes VM (O/N) ? ${NC}"
read status

case "$status" in
  o|O ) vagrant status
  sleep 4;;
  n|N ) echo -e "${TXT}Pas de problème. ${NC}"
  exit;;
  * ) echo -e "${TXT}Je n'ai pas compris ${NC}"
  read status;;
esac

sleep 1
echo -e "${TXT}La connexion en SSH va maintenant se lancer. ${NC}"
sleep 1
echo -e "${TXT}Quand la connexion sera établie, pour continuer : ${NC}"
sleep 2
echo -e "${TXT}>>> Aller dans /var/www/html avec 'cd /var/www/html' ${NC}"
sleep 1
echo -e "${TXT}>>> Puis lancer script_suite.sh avec 'bash script_suite.sh' ${NC}"
sleep 4

vagrant ssh
            