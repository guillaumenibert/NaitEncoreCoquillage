#!/bin/bash
# S'exécute uniquement en root
# sudo chown root "postinstall_ubuntu.sh"
# sudo chmod +s "postinstall_ubuntu.sh"
# sudo chmod o+x "postinstall_ubuntu.sh"

# Suppression du paquet permettant de gérer automatiquement les mises à jour
apt remove unattended-upgrades -y

# Mise à jour des dépots
apt update

# Mise à jour de l'ensemble des paquets
apt upgrade -y

# Installation de curl
apt install curl -y

# Ajout des dépots
## Partenaires de Canonical
add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner" -y
## LibreOffice
add-apt-repository ppa:libreoffice/ppa -y
## Audacity
add-apt-repository ppa:ubuntuhandbook1/audacity -y

###########################################################
## Handbrake [NON COMPATIBLE AVEC 19.04]
#add-apt-repository ppa:stebbins/handbrake-releases -y
###########################################################

## VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | sudo apt-key add - 
echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 
## Skype
curl https://repo.skype.com/data/SKYPE-GPG-KEY | sudo apt-key add -
echo "deb [arch=amd64] https://repo.skype.com/deb stable main" | sudo tee /etc/apt/sources.list.d/skype-stable.list

## Spotify
## apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90 2EBF997C15BDA244B6EBF5D84773BD5E130D1D45
## echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list

## Brave
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
source /etc/os-release
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ $UBUNTU_CODENAME main" | sudo tee /etc/apt/sources.list.d/brave-browser-release-${UBUNTU_CODENAME}.list
## Etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 379CE192D401AB61
## Riot.im
sudo apt install -y lsb-release wget apt-transport-https
sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/riot-im.list
## Signal
curl -s https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add -
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list

# Mise à jour des dépots
apt update

# Installation des paquets
## Installation de discord
cd ~/Téléchargements

wget -O "discord.deb" "https://discordapp.com/api/download?platform=linux&format=deb"
dpkg -i "discord.deb"
apt -f install -y
rm "discord.deb"

cd

# Installation des paquets
apt install vlc codium riot-web libreoffice libreoffice-l10n-fr libreoffice-help-fr thunderbird thunderbird-locale-fr skypeforlinux filezilla wire-desktop spotify-client brave-browser balena-etcher-electron default-jre synaptic -y

# Développer en Java
apt install default-jdk -y
