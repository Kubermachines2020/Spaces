#!/bin/bash
# [STEPS] Kubermachines command 
cp kubermachines /usr/local/bin/
chmod +x /usr/local/bin/kubermachines
printf "\nif [[ -f /usr/local/bin/kubermachines ]]; then\n    source /usr/local/bin/kubermachines\nfi" >> $HOME/.bashrc
source $HOME/.bashrc
