#!/bin/bash
# Perkin, Docker container status wrapper
NORMAL="\\033[0;39m"
RED="\\033[1;31m"
BLUE="\\033[1;34m"
GREEN="\\033[1;32m"
YELLOW="\\033[0;33m"

function ___check_docker(){
    if ! [ -x "$(command -v docker)" ]; then
        echo -e -n "$RED"
        echo "Error: Docker not installed - Install Docker first" >&2  
        echo -e -n "$NORMAL"
        exit 1
    fi
    
    if ! pgrep docker > /dev/null ; then     
        echo -e -n "$RED"                                   
        echo 'Error: Docker daemon is not running.' >&2
        echo -e -n "$NORMAL"                                      
        exit 1                                                                               
    fi
}

function help(){
    echo -e -n "$GREEN"
    echo "** Perkin, Docker container status wrapper **"
    echo "============================================="
    echo "List of available commands:"
    typeset -f | awk '/ \(\) $/ && !/^___check_docker / {print $1}'
    echo -e -n "$NORMAL"
}

function ps(){
    ___check_docker
    echo -e -n "$YELLOW"
    docker ps --no-trunc --format="table {{.Names}}\t{{.Image}}\t{{.Command}}"     
    echo -e -n "$NORMAL"
}

function status(){
    ___check_docker
    echo -e -n "$YELLOW"
    docker ps --no-trunc --format="table {{.Image}}\t{{.Command}}"     
    echo -e -n "$NORMAL"
}

function net(){
    ___check_docker
    echo -e -n "$YELLOW"
    docker ps --no-trunc --format="table {{.Names}}\t{{.Image}}\t{{.Networks}}\t{{.Ports}}"     
    echo -e -n "$NORMAL"
}

function storage(){
    ___check_docker
    echo -e -n "$YELLOW"
    docker ps --no-trunc --format="table {{.Names}}\t{{.Image}}\t{{.Size}}\t{{.Mounts}}"     
    echo -e -n "$NORMAL"    
}

function history(){
    ___check_docker
    echo -e -n "$YELLOW"
    docker ps --no-trunc --format="table {{.Names}}\t{{.Image}}\t{{.ID}}\t{{.RunningFor}}\t{{.CreatedAt}}\t{{.Status}}"     
    echo -e -n "$NORMAL"    
}

if [[ -z $1 ]]; then
    help
fi

"$@"