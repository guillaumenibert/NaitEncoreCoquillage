#!/bin/bash
# ================================================================
# Title : Postinstall Ubuntu Perso
# Author : Guillaume Nibert
# Version : 2.0.1
# Compatibility : Debian Testing (11)
# Comments : The script runs in sudo mode.
# ================================================================
# Changelog
#
#     Security :
#       - Removed Discord, Skype and Riot.im.
#       - Added Flatpak packages.
#     Development :
#       - Added Jetbrains CLion, PyCharm and IDEA snap packages.
#     Compatibility : Added Debian Testing (11) support.
# ================================================================

# Update of the package lists
apt update

# Upgrade packages
apt upgrade -y

# Installation of curl and apt-transport-https
apt install curl apt-transport-https -y

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
echo 'deb http://download.opensuse.org/repositories/home:/strycore/Debian_Testing/ /' > /etc/apt/sources.list.d/home:strycore.list
wget -nv https://download.opensuse.org/repositories/home:strycore/Debian_Testing/Release.key -O Release.key
apt-key add - < Release.key

# Update of the package lists
apt update

# Installation of the following packages
apt install audacity mumble vlc codium libreoffice libreoffice-l10n-fr libreoffice-help-fr \
thunderbird thunderbird-locale-fr filezilla brave-browser balena-etcher-electron default-jre \
synaptic cheese flatpak gufw handbrake chrome-gnome-shell gnome-clocks keepassxc lutris \
mkvtoolnix mkvtoolnix-gui ffmpeg qbittorrent rhythmbox totem totem-plugins \
virtualbox virtualbox-qt virtualbox-dkms torbrowser-launcher -y

# Development tools in Python, C, C++ and Java
apt install python3 gcc g++ default-jdk -y

# Snap packages
snap refresh
snap install mattermost-desktop glimpse-editor obs-studio
snap install intellij-idea-ultimate --classic
snap install pycharm-professional --classic
snap install clion --classic

# Comments
# For security reasons, the use of Discord, Skype and Riot.im is done via a privacy-friendly
# web browser.
