#!/bin/bash
export WEB_IMG_NAME=ratnadeepb/block:latest
export PROXY_IMG_NAME=ratnadeepb/blockproxy:latest

cd BLOC/app && ./docker_build.sh $WEB_IMG_NAME && cd $OLDPWD
cd BLOCProxy && ./build_proxy.sh $PROXY_IMG_NAME && cd $OLDPWD
