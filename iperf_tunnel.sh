#!/bin/bash

IP=$1
QUANTIDADE=$2
OUTPUT="$(sudo docker exec my5grantester pgrep iperf)"

for i in $(seq $QUANTIDADE)
do
   sudo docker exec upf iperf3 -s -p 52$i -D
   echo 'SERVIDOR IPERF INICIADO NA PORTA 52'$i' DA UPF ...'
done

for i in $(seq $QUANTIDADE)
do
   sudo docker exec -d my5grantester iperf3  --no-delay --client $IP --port 52$i -t 60 --bind 10.60.0.$i --interval 0 --parallel $QUANTIDADE
   echo 'CLIENTE IPERF INICIADO NO TÚNEL UETUN'$i' ...'

#while : ; do
#      if  [[ -n $output ]]
#      then
#          printf "IPERF FINALIZADO!"
#      else 
#          printf "EXECUTANDO..."
#      fi
#    sleep 1
#done
