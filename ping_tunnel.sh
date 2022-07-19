#!/bin/bash

QUANTIDADE=$1

for i in $(seq $QUANTIDADE)
do
#irá executar o ping em quantos tunéis forem passados no momento da execução do comando bash
   docker exec my5grantester ping -I uetun$i -c 60 8.8.8.8
done
