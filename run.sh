#!/bin/bash
for EXP in "lc1" "lc40" "bloc40"
do
    . deploy.sh $EXP
    sleep 120
    hey -c 100 -z 5m -disable-keepalive -o csv http://localhost:$PORT_NUM/svc/0 | tee ($EXP).csv
    sleep 20
    ./delete.sh $EXP
    sleep 120
done