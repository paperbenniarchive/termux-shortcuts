#!/bin/bash

echo "installing paperbennis termux shortcuts"

cd

if ! ping -c 1 google.com &>/dev/null; then
    echo "internet access is required"
    exit 1
fi

checkforcmd() {
    if ! command -v "$1" &>/dev/null; then
        apt-get install -y "$1"
    fi
}

checkforcmd git
checkforcmd curl

removetrigger() {
    cd
    if [ -e .shortcuts2 ]; then
        echo "removing old shortcuts"
        rm -rf .shortcuts2
    fi
    echo "renaming previous shortcuts"
    mv .shortcuts .shortcuts2
    export PSHORT="True"
}

if [ -e $HOME/.shortcuts ]; then
    if [ -e .shortcuts/.git ]; then
        cd .shortcuts
        git pull || removetrigger
    else
        removetrigger
    fi
fi

if [ -n "$PSHORT" ]; then
    echo "doing new installation"
    git clone --depth=1 https://github.com/paperbenni/termux-shortcuts.git ~/.shortcuts
    cd .shortcuts
    rm -rf .git
    rm README.md
    rm intsall.sh
    chmod +x *.sh
fi

echo "done"
