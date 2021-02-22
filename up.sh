#!/bin/bash

username=`cat  cred | grep username | cut -d "=" -f2`
password=`cat  cred | grep password | cut -d "=" -f2`
registry=`cat  cred | grep registry | cut -d "=" -f2`

function kubermachines_up (){
  docker login -u $username -p $password $registry
  export KUBECONFIG=config.yaml
  tilt up
}

kubermachines_up
