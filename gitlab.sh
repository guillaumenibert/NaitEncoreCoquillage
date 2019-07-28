#!/bin/bash

# Gitlab sur Apache
sudo apt install curl openssh-server ca-certificates postfix

curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash

sudo apt install gitlab-ce

ls -al /opt/gitlab/sv/redis/supervise # Vérification que e process supervisor (runit) est dans le bon état

systemctl restart gitlab-runsvdir.service

/opt/gitlab/embedded/bin/runsvdir-start & # Lancer le service si probleme dans le reconfigure

sudo gitlab-ctl reconfigure

# Reconfiguration pour Apache, GitLab et Mattermost
sudo nano /etc/gitlab/gitlab.rb

external_url 'http://gitlab.HOSTNAME.fr' # PAS DE HTTPS LE VHOST S'EN OCCUPE SINON TOUT CASSE
nginx['enable'] = false
web_server['external_users'] = ['www-data']

mattermost_external_url 'http://chat.HOSTNAME.fr' # IDEMM

sudo useradd -G gitlab-www www-data

sudo gitlab-ctl reconfigure

### Créer le VHost Apache gitlab.HOSTNAME.fr GitLab

sudo a2ensite gitlab.HOSTNAME.fr

sudo a2enmod proxy
sudo a2enmod proxy_http

sudo systemctl reload apache2

certbot # Génération de la clé ssl

## Créer le VHost Apache chat.HOSTNAME.fr Mattermost

sudo a2ensite chat.HOSTNAME.fr

systemctl reload apache2
certbot



gitlab-rails console production


## Reste encore le problème de jetons mattermost à gérer
