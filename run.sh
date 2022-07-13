#!/bin/bash
# Set up the cluster
. edit_cluster.sh

sleep 60

# Run the experiment
for EXP in "lc1" "lc40" "bloc40"
do
    echo "deploying $EXP"
    . deploy.sh $EXP
    sleep 120
    hey -c 100 -z 5m -disable-keepalive -o csv http://localhost:$PORT_NUM/svc/0 | tee $EXP.csv
    sleep 20
    ./delete.sh $EXP
    sleep 120
done

# Graph the data
sudo apt install python3-pip
pip install -r requirements.txt
./graph.py