#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Witaj w CodersLab!"
echo
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "których będziesz potrzebować podczas kursu oraz skonfiguruje bazę danych PostgreSQL."
echo "W tym czasie na ekranie pojawi się wiele komunikatów."
echo "ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU W TRAKCIE TRWANIA "
echo "INSTALACJI!"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

mkdir ~/.coderslab

# pausing updating grub as it might trigger ui
sudo apt-mark hold grub*
echo
echo "Aktualizuję system..."

# update / upgrade
sudo apt update
sudo apt -y upgrade
echo
echo "Instaluję narzędzia systemowe..."

# install all used tools
sudo apt install -y curl vim git virtualenv openjdk-8-jre-headless tlp tlp-rdw preload meld
sudo tlp start

echo
echo "Instaluję bazę danych PostgreSQL..."
sudo apt install -y postgresql postgresql-contrib postgresql-client pgadmin3
sudo -u postgres psql -c "ALTER USER postgres WITH PASSWORD '${PASSWORD}';"

echo
echo "Tworzę katalog roboczy..."
# creating and linkng Workspace
sudo mkdir ~/workspace
sudo chmod 777 ~/workspace
sudo chmod 777 -R ~/workspace

# PyCharm
echo
echo "Instaluję PyCharm"
sudo snap install pycharm-professional --classic

echo
echo "Dla pewności -- ponownie aktualizuję system..."
# update and upgrade all packages
sudo apt update -y
sudo apt upgrade -y

# unpausing updating grub
sudo apt-mark unhold grub*
