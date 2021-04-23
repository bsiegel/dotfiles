#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "usage: publish_oss_aar.sh <path> <group-id> <artifact-id> <version>"
    exit 1
fi

feed="https://pkgs.dev.azure.com/groupme/public/_packaging/oss/maven/v1"

echo "Publishing file $1 to feed $feed at coordinates $2:$3:$4"
read -n1 -r -p "Continue? [y/N] " yn
[[ -n $yn ]] && echo
[[ ! $yn =~ ^[Yy]$ ]] && exit

mvn deploy:deploy-file \
-DrepositoryId=oss \
-Durl="$feed" \
-Dfile="$1" \
-Dpackaging=aar \
-DgroupId="$2" \
-DartifactId="$3" \
-Dversion="$4" $flag
