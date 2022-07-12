#!/bin/bash
EXP=$1

if [[ $EXP == "" ]]
then
    echo "usage: $0 <EXP>"
    exit
fi
echo "deploying $EXP"

kubectl apply -f configs/$EXP
sleep 5
export PORT_NUM=$(kubectl get svc testapp-svc-0 -o go-template='{{range.spec.ports}}{{if .nodePort}}{{.nodePort}}{{"\n"}}{{end}}{{end}}')
