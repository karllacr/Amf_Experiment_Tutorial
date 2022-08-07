#!/bin/bash

IP=$1
QUANTIDADE=$2
OUTPUT="$(sudo docker exec my5grantester pgrep iperf)"

for i in $(seq $QUANTIDADE)
do
   docker exec upf iperf3 -s -p 52$i -D
   echo 'SERVIDOR IPERF INICIADO NA PORTA 52'$i' DA UPF ...'
   sleep 1
done

for i in $(seq $QUANTIDADE)
do
   docker exec -d my5grantester iperf3  --no-delay --client $IP --port 52$i -t 60 --bind 10.60.0.$i --interval 0 --parallel $QUANTIDADE
   echo 'CLIENTE IPERF INICIADO NO TÚNEL UETUN'$i' ...'
   sleep 1
done

while [ 1 ]
do
   PROCESS=`docker exec my5grantester pgrep iperf`
   
   if [ "$PROCESS" = "" ]
   then
      echo "IPERF FINALIZADO!"
      break
   else
      echo "IPERF AINDA EM EXECUÇÃO..."
   fi
done
