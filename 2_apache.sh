#!/bin/bash

sudo apt update && sudo apt upgrade

## Installation d'Apache
sudo apt install apache2 php libapache2-mod-php mysql-server php-mysql

sudo apt install php-curl php-gd php-intl php-json php-mbstring php-xml php-zip

# Activation du module SSL/TLS

sudo a2enmod ssl
sudo systemctl reload apache2

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:certbot/certbot
sudo apt update
sudo apt install certbot python-certbot-apache 

######################################################
###### LIGNE A CHANGER SI CHANGEMENT DE SERVEUR ######
###### Récupération d'un certificat letsencrypt ######
######################################################
sudo certbot --apache # https://certbot.eff.org/lets-encrypt/ubuntubionic-apache

## Installation de phpMyadmin

sudo apt update && sudo apt install phpmyadmin

# Si erreur 404
sudo ln -s /etc/phpmyadmin/apache.conf /etc/apache2/conf-available/phpmyadmin.conf
sudo ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin
sudo service apache2 restart

# Création d'un admin de la BDD

sudo mysql -p -u root # Ouvrir MySQL
CREATE USER 'admin'@'%' IDENTIFIED BY 'password_here';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'%' WITH GRANT OPTION;
exit # Quitter MySQL