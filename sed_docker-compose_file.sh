#!bin/bash

QUANTIDADE=$1
ARQUIVO='docker-compose.yaml'
VELHASTRING="./app ue"
SUBSTRING="./app load-test -n "
NOVASTRING="$SUBSTRING""$QUANTIDADE"

sed -i "s#$VELHASTRING#$NOVASTRING#g" "$ARQUIVO"
