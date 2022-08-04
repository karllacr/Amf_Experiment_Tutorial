#!/bin/bash

IP=$1
QUANTIDADE=$2
OUTPUT="$(docker exec my5grantester pgrep iperf)"

for i in $(seq $QUANTIDADE)
do

   sudo docker exec upf iperf3 -s -p 52$QUANTIDADE
   sudo docker exec -d my5grantester iperf3  --no-delay --client $IP --port 52$2 -t 60 --bind 10.60.0.$2 --interval 0 --parallel 5
   
   echo 'IPERF INICIADO NO TÚNEL UETUN'$i' ...'
done

while : ; do
      if  [[ -n $output ]]
      then
          printf "IPERF FINALIZADO!"
      else 
          printf "EXECUTANDO..."
      fi
    sleep 1
done
