#!/bin/bash

IP=$1
QUANTIDADE=$2
OUTPUT="$(docker exec my5grantester pgrep iperf)"

#executar o lado servidor do iperf em background

sudo docker exec upf apt-get install iperf3 -y
sudo docker exec upf iperf3 -s -D
sudo docker exec my5grantester apt-get update 
sudo docker exec my5grantester apt-get install iperf3 -y

for i in $(seq $QUANTIDADE)
do

   sudo docker exec upf iperf3 -s -p 52$QUANTIDADE
   sudo docker exec -d my5grantester iperf3  --no-delay --client $IP --port 52$2 -t 60 --bind 10.60.0.$2 --interval 0 --parallel 1
   
   echo 'IPERF INICIADO NO TÚNEL UETUN'$i' ...'
done

echo 'EXECUTANDO...'

while : ; do
      if ! [[ -n $output ]]
      then
          printf "\nIPERF FINALIZADO!"
      fi
    sleep 2
done
