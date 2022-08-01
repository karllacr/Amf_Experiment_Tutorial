#!/bin/bash

IP=$2
QUANTIDADE=$1

#executar o lado servidor do iperf em background

sudo docker exec -it upf iperf3 -s -D

for i in $(seq $QUANTIDADE)
do
#irá executar o iperf através de cada um dos túneis criados
   docker exec -d my5grantester iperf3 -c $2 -t 60 -B 10.60.0.$i 
   echo 'Iperf iniciado no túnel uetun'$i' ...'
done

#monitorar o ping no container e sinalizar quando for finalizado
echo 'Executando...'
while : ; do
    if ! docker exec my5grantester pgrep -x 'ping' > /dev/null
    then
        printf "\nIperf Finalizado!"
        break
    fi
    sleep 2
done
