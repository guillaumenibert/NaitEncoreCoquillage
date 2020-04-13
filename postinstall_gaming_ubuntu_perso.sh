#!/bin/bash
# ================================================================
# Title : Postinstall Gaming Ubuntu Perso
# Author : Guillaume Nibert
# Version : 2.0
# Compatibility : Ubuntu 18.04 LTS, 18.10, 19.04, 19.10, 20.04 LTS
# ================================================================

# Adding the Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installation of the following packages
flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.valvesoftware.Steam
flatpak install flathub com.mojang.Minecraft