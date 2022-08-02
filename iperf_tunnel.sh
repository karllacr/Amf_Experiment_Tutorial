#!/bin/bash

IP=$1
QUANTIDADE=$2

#executar o lado servidor do iperf em background

sudo docker exec upf apt-get install iperf3 -y
sudo docker exec upf iperf3 -s -D
sudo docker exec my5grantester apt-get update && apt-get install iperf3 -y

for i in $(seq $QUANTIDADE)
do
#irá executar o iperf através de cada um dos túneis criados
   sudo docker exec -d my5grantester iperf3 -c $1 -t 60 -B 10.60.0.$2 
   echo 'Iperf iniciado no túnel uetun'$i' ...'
done

#monitorar o ping no container e sinalizar quando for finalizado
echo 'Executando...'
while : ; do
    if ! docker exec my5grantester pgrep -x 'iperf' > /dev/null
    then
        printf "\nIperf Finalizado!"
        break
    fi
    sleep 2
done
