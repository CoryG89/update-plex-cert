#!/bin/bash

domainName=corygross.io
domainPath=/etc/letsencrypt/live/$domainName

certPath=$domainPath/fullchain.pem
keyPath=$domainPath/privkey.pem
archivePath=$domainPath/archive.pfx

pmsPath=$PLEX_HOME/Library/Application\ Support/Plex\ Media\ Server
pmsPrefPath=$pmsPath/Preferences.xml

archivePlexDestPath=$pmsPath/$domainName.pfx

# Generate a random 32 bit key for encrypting the archive
archivePassword=$(openssl rand -base64 32)

# Generate encrypted archive package using key and certificate and random key
openssl pkcs12 -export -in $certPath -inkey $keyPath -out $archivePath -name $domainName -password pass:"$archivePassword"

# Copy the encrypted archive to and change the owner to plex
cp $archivePath "$archivePlexDestPath"
chown plex:plex "$archivePlexDestPath"

# Update plex server preferences with the encrypted archive
xmlstarlet ed --inplace -u "/Preferences/@customCertificateKey" -v "$archivePassword" -u "/Preferences/@customCertificatePath" -v "$archivePlexDestPath" -u "/Preferences/@customCertificateDomain" -v $domainName "$pmsPrefPath"

# Restart the plex service so it can start using the new archive
service plexmediaserver restart
