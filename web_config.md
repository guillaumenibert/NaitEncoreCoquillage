# DNS over HTTPS

## Mozilla Firefox (Desktop and Android, not tested on iOS)

Temporarily using DoH from the Foundation for Applied Privacy.

Parameters :

```
network.trr.mode;2
```
```
network.trr.uri;https://doh.applied-privacy.net/query
```
```
network.security.esni.enabled;true
```

## Chromium-based browsers

Don't use Chromium-based browsers !

https://github.com/bromite/bromite/wiki/Enabling-DNS-over-HTTPS

### Test DoH and eSNI : https://www.cloudflare.com/ssl/encrypted-sni/

## TO DO

https://blog.plip.com/2018/04/22/stubby-pi-hole-quad9-lxd/

# DNS over TLS (from the Foundation for Applied Privacy)

## Android >= 9

DoT : dot1.applied-privacy.net

## Android < 9

Use Intra with DNS over HTTPS : Android : dot1.applied-privacy.net

# Enable support of TLS 1.3 (client side)

## Mozilla Firefox (Desktop and Android, not tested on iOS)

```
security.tls.version.max;4
```

## Chromium-based browsers (only tested with Brave Browser)

```
TLS 1.3 Early Data;Default
```
```
TLS 1.3 downgrade hardening;Default
```

### Test TLS 1.3 : https://www.cloudflare.com/ssl/encrypted-sni/

# Enable AV1 (client side)

## Mozilla Firefox (Desktop and Android, not tested on iOS)

```
media.av1.enabled;true
```
```
media.av1.use-dav1d;true
```

## Chromium-based browsers

```
chrome://flags/#enable-av1-decoder
```

# Privacy

https://www.privacytools.io/ /!\ `privacy.resistFingerprinting = true` breaks some web apps (e.g. Jitsi Meet).
https://vive-gnulinux.fr.cr/securiser-firefox/

https://privacymachine.xyz/

https://textup.fr/277731WL (credits : LBD22)
