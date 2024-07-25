#!/usr/bin/env bash

# Use single quotes instead of double quotes to make it work with special-character passwords
PASSWORD='coderslab'
HOSTNAME='student.edu'

echo
echo "Witaj w CodersLab!"
echo
echo "Ten skrypt zaktualizuje Twój system, zainstaluje kilka niezbędnych programów,"
echo "których będziesz potrzebować podczas kursu oraz skonfiguruje bazę danych Postgres."
echo "W tym czasie na ekranie pojawi się wiele komunikatów."
echo "ABY INSTALACJA SIĘ POWIODŁA MUSISZ MIEĆ DOSTĘP DO INTERNETU W TRAKCIE TRWANIA "
echo "INSTALACJI!"
read -n1 -r -p "Naciśnij dowolny klawisz, by kontynuować."

echo
echo "Instaluję narzędzia konsolowe..."
# install Command Line Tools for Xcode
xcode-select --install


echo
echo "Instaluję homebrew..."
# install brew package manager
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'export PATH=/opt/homebrew/bin:$PATH' >> ~/.zshrc

echo "Aktualizuję Homebrew do najnowszej wersji..."
brew update

echo "Instaluje system kontroli wersji git"
brew install git

echo
echo "Dodaję niezbędne repozytoria homebrew..."
# add external taps
brew tap homebrew/services
brew tap homebrew/cask-versions
echo
echo "Instaluję narzędzia systemowe..."

echo "Instaluję Pythona"
brew install curl vim python3 wget screen

pip3 install --user virtualenv termcolor pycodestyle

echo
echo "Instaluję PostgreSQL..."
# install pgsql
brew install postgresql@14

# start service
brew services start postgresql

sleep 3
# change password
createuser postgres
createdb coderslab
psql -U postgres -c "ALTER USER postgres WITH PASSWORD '${PASSWORD}';"

echo
echo "Instaluję PyCharm Professional"
brew install --cask pycharm

echo
echo "Tworzę katalog roboczy..."
# creating and linkng Workspace
mkdir ~/workspace
chmod 777 -R ~/workspace

echo
echo "Dla pewności -- ponownie aktualizuję system..."
# update and upgrade all packages
brew update
brew upgrade

echo "#############################"
echo "####INSTALACJA ZAKOŃCZONA####"
echo "#############################"
echo "Wejdź do Aplikacji i uruchom Pycharm"
