#!/bin/bash
EXP=$1

if [[ $EXP == "" ]]
then
    echo "usage: $0 <EXP>"
    exit
fi
echo "deleting $EXP"

kubectl delete -f configs/$EXP