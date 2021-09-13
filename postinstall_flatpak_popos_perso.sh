#!/bin/bash
# ================================================================
# Title : Postinstall Flatpak Ubuntu Perso
# Author : Guillaume Nibert
# Version : 2.2.0
# Compatibility : Pop! OS 20.04 LTS
# Changelog
#
#     Development :
#       - Added Mattermost, PyCharm and CLion
# ================================================================

# Adding the Flathub repository
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Installation of the following packages


flatpak install flathub com.github.tchx84.Flatseal
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.spotify.Client
flatpak install flathub im.riot.Riot
flatpak install flathub chat.rocket.RocketChat
flatpak install flathub io.freetubeapp.FreeTube
flatpak install flathub me.hyliu.fluentreader
flatpak install flathub org.mozilla.Thunderbird
flatpak install flathub org.signal.Signal
flatpak install flathub com.skype.Client


# http://jorisvr.nl/article/steam-firejail-debian
