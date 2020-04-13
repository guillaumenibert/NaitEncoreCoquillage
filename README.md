# TODO

## postinstall_ubuntu_perso.sh and postinstall_ubuntu_perso_minimal.sh

Added compatibility for Ubuntu 20.04 LTS.
Added a minimal version of the script for old PCs.

## jeedom_raspbian.sh (based on Raspbian Duster 10 Lite)

- Install Jeedom.
- Adapt the installer script to Raspbian based on Debian Duster.
- Install drivers for ZWave Plus and ZigBee communication protocols.

## config_vps_server.sh (based on Ubuntu Server 18.04 LTS)

- Apache
- PostgreSQL -> MySQL -> MariaDB

- Gitlab + Mattermost

- HTTPS : Certbot with Let's Encrypt

- Optional : Webmail


## SECURITY

On Apache and Nginx
- HTTP2 Protocol
- TLS 1.3 + Disable all SSL versions and all TLS versions < 1.2
- SSL Cipher

- Let's Encrypt : RSA 4096

Unbound DNS Server + DNS over TLS
/!\ DNS over HTTPS with Cloudflare

## OPERATION SMA-ACTIVE

- Docker
- Let's Encrypt : Elliptic Curve
- Nextcloud
- OAuth
- NVIDIA Jetson
- Update scripts
