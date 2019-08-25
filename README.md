# TODO

## postinstall_ubuntu_perso.sh (based on Ubuntu 19.04 Desktop)

Add post-configuration scripts

## jeedom_raspbian.sh (based on Raspbian Duster 10 Lite)

- Install Jeedom.
- Adapt the installer script to Raspbian based on Debian Duster.
- Install drivers for ZWave Plus and ZigBee communication protocols.

## config_vps_server.sh (based on Ubuntu Server 18.04.2 LTS)

- Docker

- Apache
- PostgreSQL, MySQL or MariaDB ?

- Gitlab + Mattermost

- HTTPS : Certbot with Let's Encrypt

- Optional : Webmail


## SECURITY

On Apache and Nginx
HTTP2 Protocol
TLS 1.3 + Disable all SSL versions and all TLS versions < 1.1
SSL Cipher

Let's Encrypt : RSA 4096

Unbound DNS Server + DNS over TLS
/!\ DNS over HTTPS with Cloudflare
