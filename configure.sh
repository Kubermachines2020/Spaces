#!/bin/bash
PWD=$(grep PWD .cred | xargs)
PWD=${PWD#*=}

USERNAME=$(grep USERNAME .cred | xargs)
USERNAME=${USERNAME#*=}

REGISTRY=$(grep REGISTRY .cred | xargs)
REGISTRY=${REGISTRY#*=}

DEPLOYMENT=$(grep DEPLOYMENT .cred | xargs)
DEPLOYMENT=${DEPLOYMENT#*=}

NAMESPACE=$(grep NAMESPACE .cred | xargs)
NAMESPACE=${NAMESPACE#*=}

function kubermachines_configure (){
  echo $PWD | docker login --username $USERNAME --password-stdin $REGISTRY
  cp $CONTEXT_FILE ~/.kube/config
  kubectl create secret docker-registry $DEPLOYMENT --docker-server=https://index.docker.io/v1/ --docker-username=$USERNAME --docker-password=$PWD -n $NAMESPACE
}

kubermachines_configure
