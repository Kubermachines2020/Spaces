#!/bin/bash
PWD=$(grep PWD .cred | xargs)
PWD=${PWD#*=}
USERNAME=$(grep USERNAME .cred | xargs)
USERNAME=${USERNAME#*=}
REGISTRY=$(grep REGISTRY .cred | xargs)
REGISTRY=${REGISTRY#*=}

function kubermachines_configure (){
  echo $PWD | docker login --username $USERNAME --password-stdin $REGISTRY
  export KUBECONFIG=config.yaml
}

kubermachines_configure
