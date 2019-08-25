# DNS over HTTPS

## Mozilla Firefox (Desktop and Android, not tested on iOS)

Temporarily using DoH from Quad9.

Parameters :

```
network.trr.bootstrapAddress;9.9.9.9
```
```
network.trr.mode;3
```
```
network.trr.uri;https://dns.quad9.net/dns-query
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

# DNS over TLS (from Quad9)

## Android (min 9)

https://www.quad9.net/private-dns-quad9-android9/

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

### Turn on AV1 on YouTube : https://www.youtube.com/testtube
