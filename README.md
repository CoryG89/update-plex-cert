# update-plex-cert

Script to update plex ssl certificate automatically on renewal.

## Dependencies

The only dependency for this script is xmlstarlet which is used to manipulate the XML config file used by Plex. If you are using an Ubuntu/Debian based distribution of Linux, then you can install xmlstarlet by running:

```sh
$  sudo apt install xmlstarlet
```

## Install

If you are using letsencrypt then you can run the following which will download and copy the script into the deploy hooks for letsencrypt so that it runs automatically on successful renewal.

```sh
$  git clone https://github.com/CoryG89/update-plex-cert.git
$  cd update-plex-cert
$  npm run install-letsencrypt
```
