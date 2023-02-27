#! /usr/bin/env bash

extensions(){
    cat /opt/config/extensions.txt | while read extension || [[ -n $extension ]];
    do
    code-server --install-extension $extension --force
    done
}

launch(){
    code-server --config /opt/config/config.yaml
}

main(){
    extensions
    launch
}

main
