#!/bin/bash

QUANTIDADE=$1

for i in $(seq $QUANTIDADE)
do
#irá executar o ping em quantos tunéis forem passados no momento da execução do comando bash
   docker exec -d my5grantester ping -I uetun$i -c 60 8.8.8.8
   echo 'PINGANDO NO TÚNEL UETUN'$i' ...'
done

#monitorar o ping no container e sinalizar quando for finalizado
echo 'Executando...'
while : ; do
    if ! docker exec my5grantester pgrep -x 'ping' > /dev/null
    then
        printf "\nPINGS FINALIZADOS!"
        break
    fi
    sleep 2
done
