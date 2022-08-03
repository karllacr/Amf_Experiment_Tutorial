#!/bin/bash

IP=$1
QUANTIDADE=$2
OUTPUT="$(docker exec my5grantester pgrep iperf)"

#executar o lado servidor do iperf em background

sudo docker exec upf apt-get install iperf3 -y > /dev/null 2>&1 &
sudo docker exec upf iperf3 -s -D > /dev/null 2>&1 &
sudo docker exec my5grantester apt-get update > /dev/null 2>&1 &
sudo docker exec my5grantester apt-get install iperf3 -y > /dev/null 2>&1 &

echo "\n VERIFICANDO A EXISTÊNCIA DOS PROGRAMAS NECESSÁRIOS..."
sleep 6

for i in $(seq $QUANTIDADE)
do

   sudo docker exec upf iperf3 -s -p 52$QUANTIDADE
   sudo docker exec -d my5grantester iperf3  --no-delay --client $IP --port 52$2 -t 60 --bind 10.60.0.$2 --interval 0 --parallel 1
   
   echo 'IPERF INICIADO NO TÚNEL UETUN'$i' ...'
done

while : ; do
      if  [[ -n $output ]]
      then
          printf "\nEXECUTANDO..."
      else 
          printf "\n'IPERF FINALIZADO!"
      fi
    sleep 2
done
