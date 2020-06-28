#!/bin/bash
# ================================================================
# Title : Postinstall Flatpak Ubuntu Perso
# Author : Guillaume Nibert
# Version : 2.1.0
# Compatibility : Ubuntu 18.04 LTS, 18.10, 19.04, 19.10, 20.04 LTS
# Changelog
#
#     Development :
#       - Added Mattermost, PyCharm and CLion
# ================================================================

# Adding the Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installation of the following packages


flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.mojang.Minecraft
flatpak install flathub com.mattermost.Desktop
flatpak install flathub com.jetbrains.PyCharm-Professional
flatpak install flathub com.jetbrains.IntelliJ-IDEA-Ultimate

# http://jorisvr.nl/article/steam-firejail-debian
