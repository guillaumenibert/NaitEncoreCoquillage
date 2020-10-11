<div align="center">

# Mise en place du serveur VPN Freebox IPsec/IKEv2 avec un nom de domaine personalisé et un certificat Let's Encrypt ECDSA



| Auteur               | Version | Date         | Historique des modifications    |
| -------------------- | ------- | ------------ | ------------------------------- |
| Guillaume Nibert     | 0.1.0   | 2020-10-04   | Première version du tutoriel    |
| Guillaume Nibert     | 0.1.1   | 2020-10-06   | Fix commentaires ipsec.conf     |
| Guillaume Nibert     | 0.2.0   | 2020-10-11   | Ajout recommandation empirique  |

</div>

## Prérequis

<br>

* Être propriétaire d'un nom de domaine
* [Optionel, recommandé] Avoir une machine Linux type Debian
* Avoir des bases en architecture réseau et connaître les systèmes Linux

<br>

## Ajout d'un nom de domaine

<br>

Se rendre dans les paramètres de la freebox ([192.168.0.254](192.168.0.254) ou [mafreebox.free.fr](mafreebox.free.fr)) : `Paramètres de la Freebox` > `Mode avancé` > `Nom de domaine`.

1. Ajouter un nom de domaine 
2. `Je veux ajouter un nom de domaine que j'ai déjà configuré`
3. Spécifier le nom de domaine : `vpn.example.org` (remplacer `vpn.example.org` par le domaine de votre vpn).
4. Ajouter un champ `CNAME` dans l'interface de gestion de votre service de noms de domaine, la valeur est donnée par la Freebox (s'il n'est pas possible d'ajouter un champ `CNAME`, ajouter un champ `A` **et** un champ `AAAA` donnés eux aussi dans l'interface de la Freebox). Le processus peut prendre un certain temps selon le TTL que vous aurez défini, conseil mettez une valeur faible du TTL (60 secondes) pour la configuration, puis une fois fait vous pouvez la mettre à une valeur plus élevée.
5. `Oui je souhaite importer un certificat TLS`
6. Réduire la fenêtre de votre navigateur Internet, nous allons passer à la création du certificat Let's Encrypt avec une clef ECDSA...

<br>

## Création du certificat Let's Encrypt (ECDSA)

<br>

Création d'une clef ECDSA P-384, il s'agit de la clef la plus robuste acceptée par Let's Encrypt ([https://letsencrypt.org/fr/docs/integration-guide/#algorithmes-de-clefs-pris-en-charge](https://letsencrypt.org/fr/docs/integration-guide/#algorithmes-de-clefs-pris-en-charge)). Si vous souhaitez davantage de compatibilité vous pouvez créer un double certificat en ajoutant une clef RSA (non couvert dans ce tutoriel).

1. Génération de la clef privée avec l'algorithme `secp384r1`.

```bash
openssl ecparam -genkey -name secp384r1 -out privkey.pem -outform pem
```

2. Vérification de l'algorithme utilisé sur cette clef nouvellement créée.

```bash
openssl ec -in privkey.pem -noout -text
```

3. Création d'un fichier de demande de signature de certificat (Certificate Signing Request (CSR)), remplacer `vpn.example.org` par le domaine de votre vpn.

```bash
openssl req -new -sha512 -key privkey.pem -nodes -subj "/CN=vpn.example.org" -reqexts SAN -extensions SAN -config <(cat /etc/ssl/openssl.cnf <(printf "[SAN]\nsubjectAltName=DNS:vpn.example.org")) -out csr.pem -outform pem
```

4. Vérification du CSR

```bash
openssl req -in csr.pem -noout -text
```

5. Demander le certificat à l'autorité Let's Encrypt.

ATTENTION : Généralement, le challenge [DNS-01](https://letsencrypt.org/fr/docs/challenge-types/) est automatisé avec Certbot par avec l'utilisation d'un plugin fourni par votre fournisseur de noms de domaine. La liste de ces plugins est disponible ici : https://certbot.eff.org/docs/using.html?highlight=dns#dns-plugins

Ci-dessous, la requête a été faite avec le plugin fourni par le service de noms de domaines [Njalla](https://njal.la/) : 
https://pypi.org/project/certbot-dns-njalla/

```
sudo certbot certonly -a certbot-dns-njalla:dns-njalla --certbot-dns-njalla:dns-njalla-credentials njalla.ini --server "https://acme-v02.api.letsencrypt.org/directory" --domain "vpn.example.org" --csr csr.pem
```

Les fichiers créés sont les suivants, vous pouvez les voir en tapant la commande `ls` :
 * `0000_cert.pem` : Certificat du serveur (vpn.example.org) ;
 * `0000_chain.pem` : Certificat intermédiaire ;
 * `0001_chain.pem` : La concaténation du certificat serveur et du certificat intermédiaire
 * `privkey.pem` : La clé privée.

Plus d'information sur le processus d'émissions de certificats Let's Encrypt : https://letsencrypt.org/fr/certificates/

<br>

## Finalisation de la création du serveur VPN Freebox

<br>

On revient sur l'onglet Internet de l'interface de configuration de la Freebox.

7. Type de clef : `ECDSA` ;
8. Certificat : copier-coller le contenu de `0000_cert.pem` ;
9. Clé privée : copier-coller le contenu de `privkey.pem` ;
10. Certificat intermédiaire : copier-coller le contenu de `0000_chain.pem`, puis cliquer sur `Suivant` ;
11. Valider, puis aller dans la partie `Serveur VPN` des paramètres de la Freebox ;
12. Dans la section `Utilisateurs`, ajouter un nouvel utilisateur (ici, `login = VpnUser`, `mot de passe = AzertY`, `IP Fixe : comme vous voulez`) ;
13. Dans la section `IPsec IKEv2`, Activer le serveur.

C'est terminé !

<br>

## Connexion au VPN depuis une machine Linux Debian

<br>

1. Installer strongswan

```bash
sudo apt install strongswan libcharon-extra-plugins
```

2. Configurer la connexion

```bash
sudo nano /etc/ipsec.conf
```

Remplacer le contenu actuel par celui ci-dessous :

```bash
# ipsec.conf - strongSwan IPsec configuration file

# basic configuration

config setup
        # strictcrlpolicy=yes
        # uniqueids = no

# Add connections here.

# nom de la connexion
conn freebox
        keyexchange=ikev2
        dpdaction=clear
        dpddelay=300s
        # le login de l'utilisateur
        eap_identity="VpnUser"
        leftauth=eap-mschapv2
        left=%defaultroute
        leftsourceip=%config
        # le domaine associé
        right=vpn.example.org
        rightauth=pubkey
        rightsubnet=0.0.0.0/0
        rightid=%SERVER
        # le chemin vers le certificat fullchain (rem : faire un chmod 600 si nano en root)
        rightcert=0001_chain.pem
        type=tunnel
        auto=add

include /var/lib/strongswan/ipsec.conf.inc
```

3. Rentrer les informations de connexion

```bash
sudo nano /etc/ipsec.secrets
```

Ajouter le nom d'utilisateur et le mot de passe de votre utilisateur de cette façon : `login : EAP mot_de_passe` ; le contenu final doit ressembler à cela :

```bash
# This file holds shared secrets or RSA private keys for authentication.

# RSA private key for this host, authenticating it to any other host
# which knows the public part.

VpnUser : EAP AzertY 

# this file is managed with debconf and will contain the automatically created private key
include /var/lib/strongswan/ipsec.secrets.inc
```

4. Redémarrer le service strongswan

```bash
sudo ipsec restart
```

5. Se connecter au VPN

```bash
sudo ipsec up freebox
```

Vous êtes connecté·e !

<br>

## Remarques diverses

<br>

* Pour une version graphique du client pour Linux/Gnome : `sudo apt install network-manager-strongswan libcharon-extra-plugins`

* Pour Android, il s'agit du client [strongSwan](https://play.google.com/store/apps/details?id=org.strongswan.android&hl=fr).

* IPsec/IKEv2 opère sur la couche 3 du modèle TCP/IP à la différence d'OpenVPN qui opère sur les couches 5 et 6, les deux sécurisent les données dans leurs couches respectives, plus d'infos : https://security.stackexchange.com/questions/105967/ikev2-vs-openvpn.

* Si la connexion ne fonctionne pas du premier coup (IKE AUTHENTIFICATION FAILED) essayer sur un nom de domaine example.freeboxos.fr et revenir le nom domaine vpn.example.org précédemment configuré.
