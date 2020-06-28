#!/bin/bash
# ================================================================
# Title : Postinstall Ubuntu Perso
# Author : Guillaume Nibert
# Version : 2.1.1
# Compatibility : Ubuntu 18.04 LTS, 18.10, 19.04, 19.10, 20.04 LTS
# Comments : The script runs in sudo mode.
# ================================================================
# Changelog
#
#     Security (transfer from snap to flatpak) :
#       - Removed Mattermost, Jetbrains PyCharm and IntelliJ IDEA
#     Photography :
#       - Removed Glimpse
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

## Lutris
add-apt-repository ppa:lutris-team/lutris -y

## OBS Studio
add-apt-repository ppa:obsproject/obs-studio -y

## Veracrypt
add-apt-repository ppa:unit193/encryption -y

## Blender
add-apt-repository ppa:thomas-schiex/blender -y

# Update of the package lists
apt update

# Installation of the following packages
apt install audacity mumble vlc codium libreoffice libreoffice-l10n-fr libreoffice-help-fr \
thunderbird thunderbird-locale-fr filezilla brave-browser balena-etcher-electron default-jre default-jdk \
synaptic cheese flatpak gufw handbrake chrome-gnome-shell gnome-clocks keepassxc lutris \
mkvtoolnix mkvtoolnix-gui ffmpeg obs-studio qbittorrent rhythmbox totem totem-plugins \
veracrypt virtualbox virtualbox-qt virtualbox-dkms torbrowser-launcher hexchat cpufrequtils -y

# Development tools in Python, C, C++ and Java
apt install python3 gcc g++ default-jdk -y

# Snap packages
snap refresh
snap install clion --classic

# Comments
# For security reasons, the use of Discord, Skype and Riot.im is done via a privacy-friendly
# web browser.
