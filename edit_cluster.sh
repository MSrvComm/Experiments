#!/bin/bash
cd BLOCControl/restEpWatcher && ./deploy.sh && cd $OLDPWD
kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl label $(kubectl get nodes | awk 'NR>1 {print $1} NR==4{exit}' | tr '\n' ' ') workload=svc1
kubectl label $(kubectl get nodes | awk 'NR==5 {print $1}') workload=svc1