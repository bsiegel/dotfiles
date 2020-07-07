#!/bin/sh
pushd /usr/local/share/gyb
gyb --service-account --email $1
zip -qrm GYB-GMail-Backup-$1.zip GYB-GMail-Backup-$1
popd
mv /usr/local/share/gyb/GYB-GMail-Backup-$1.zip .
echo "Done."

