#!/bin/bash
# ================================================================
# Title : Postinstall Ubuntu Perso
# Author : Guillaume Nibert
# Version : 2.2.0
# Compatibility : Pop! OS 20.04 LTS
# Comments : The script runs in sudo mode.
# ================================================================
# Changelog
#
#     Security :
#       - Added Palemoon
#     Tools :
#       - Added Gnome Tweak Tool
# ================================================================


# Removal of the package allowing to manage updates automatically
apt remove unattended-upgrades -y

# Update of the package lists
apt update

# Upgrade packages
apt upgrade -y --allow-downgrades

# Installation of curl and apt-transport-https
apt install curl apt-transport-https -y

# Adding software repositories
## LibreOffice
add-apt-repository ppa:libreoffice/ppa -y

## VSCodium
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' | sudo tee /etc/apt/sources.list.d/vscodium.list

## Brave Browser
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list

## Etcher
curl -1sLf \
   'https://dl.cloudsmith.io/public/balena/etcher/setup.deb.sh' \
   | sudo -E bash

## OBS Studio
#add-apt-repository ppa:obsproject/obs-studio -y

## Veracrypt
add-apt-repository ppa:unit193/encryption -y

## Palemoon
echo 'deb http://download.opensuse.org/repositories/home:/stevenpusser/xUbuntu_20.04/ /' | sudo tee /etc/apt/sources.list.d/home:stevenpusser.list
curl -fsSL https://download.opensuse.org/repositories/home:stevenpusser/xUbuntu_20.04/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_stevenpusser.gpg > /dev/null

# Update of the package lists
apt update

# Installation of the following packages
apt install vlc codium libreoffice-l10n-fr libreoffice-help-fr libreoffice \
thunderbird thunderbird-locale-fr filezilla brave-browser balena-etcher-electron default-jre default-jdk \
synaptic cheese gufw handbrake chrome-gnome-shell keepassxc \
qbittorrent gnome-tweaks \
veracrypt virtualbox virtualbox-qt virtualbox-dkms torbrowser-launcher \
palemoon gnome-tweaks snapd -y

# Development tools in Python, C, C++ and Java
apt install python3 gcc g++ default-jdk -y

# Snap packages
snap refresh

# Comments
# For security reasons, the use of Discord, Skype and Riot.im is done via a privacy-friendly
# web browser.
