#!/bin/bash

IP=$1
QUANTIDADE=$2
OUTPUT="$(sudo docker exec my5grantester pgrep iperf)"

for i in $(seq $QUANTIDADE)
do
   sudo docker exec upf iperf3 -s -p 52$QUANTIDADE -D
   echo 'SERVIDOR IPERF INICIADO NA PORTA 52'$i' DA UPF ...'
done


#sudo docker exec -d my5grantester iperf3  --no-delay --client $IP --port 52$2 -t 60 --bind 10.60.0.$2 --interval 0 --parallel 5
#echo 'SERIVOR IPERF INICIADO NO TÚNEL UETUN'$i' ...'

#while : ; do
#      if  [[ -n $output ]]
#      then
#          printf "IPERF FINALIZADO!"
#      else 
#          printf "EXECUTANDO..."
#      fi
#    sleep 1
#done
