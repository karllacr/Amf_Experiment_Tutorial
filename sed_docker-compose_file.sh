#!bin/bash

QUANTIDADE=$1
ARQUIVO='free5gc-my5G-RANTester-docker/docker-compose.yaml'
VELHASTRING="./app ue"
SUBSTRING="./app load-test -n "
NOVASTRING="$SUBSTRING""$QUANTIDADE"

sed -i "s#$VELHASTRING#$NOVASTRING#g" "$ARQUIVO"
