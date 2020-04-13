#!/bin/bash
# ================================================================
# Title : Postinstall Ubuntu Perso (minimal)
# Author : Guillaume Nibert
# Version : 2.0
# Compatibility : Ubuntu 18.04 LTS, 18.10, 19.04, 19.10, 20.04 LTS
# Comments : The script runs in sudo mode.
# ================================================================
# Changelog
#
#     Security :
#       - Removed Discord, Skype and Riot.im.
#     Compatibility : Added Ubuntu 20.04 LTS support.
# ================================================================


# Removal of the package allowing to manage updates automatically
apt remove unattended-upgrades -y

# Update of the package lists
apt update

# Upgrade packages
apt upgrade -y

# Installation of curl and apt-transport-https
apt install curl apt-transport-https -y

# Adding software repositories
## LibreOffice
add-apt-repository ppa:libreoffice/ppa -y

## VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | apt-key add -
echo 'deb https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/repos/debs/ vscodium main' | tee --append /etc/apt/sources.list.d/vscodium.list

## Brave Browser
curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | tee /etc/apt/sources.list.d/brave-browser-release.list

## Etcher
echo "deb https://deb.etcher.io stable etcher" | sudo tee /etc/apt/sources.list.d/balena-etcher.list
apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv-keys 379CE192D401AB61

# Update of the package lists
apt update

# Installation of the following packages
apt install audacity vlc codium libreoffice libreoffice-l10n-fr libreoffice-help-fr \
thunderbird thunderbird-locale-fr filezilla brave-browser balena-etcher-electron default-jre \
synaptic cheese gufw chrome-gnome-shell gnome-clocks rhythmbox totem totem-plugins \
torbrowser-launcher -y

# Development tools in Python, C, C++ and Java
apt install python3 gcc g++ default-jdk -y

# Comments
# For security reasons, the use of Discord, Skype and Riot.im is done via a privacy-friendly
# web browser.