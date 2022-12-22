#!/usr/bin/env bash

PROJECT_FOLDER=$(cd `dirname $0` && pwd)

has_command () {
    if ! command -v $1 &> /dev/null
    then
        return -1
    fi
    return 0

}

set_up_links () {
    echo "Setting up links ..."
    mkdir -p $HOME/.config/nvim/
    ln -nfs $PROJECT_FOLDER/init.lua $HOME/.config/nvim/init.lua
    ln -nfs $PROJECT_FOLDER/lua $HOME/.config/nvim/lua
}

check_if_platform_supported () {
    if [ "$(uname)" == "Darwin" ]; then
        return 0
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        return 0
    else
        echo "Platform not supported. Supported Platforms are \"Darwin\" and \"Linux\""
        exit 1
    fi
}

install_nix () {
    echo "Install nix ..."
    if [ "$(uname)" == "Darwin" ]; then
        sh <(curl -L https://nixos.org/nix/install)
    elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
        sh <(curl -L https://nixos.org/nix/install) --daemon
    else
        echo "Platform not supported. Supported Platforms are \"Darwin\" and \"Linux\""
        exit 1
    fi
    exec "$SHELL"
}

install_dependencies () {
    echo "Install dependencies ..."
    nix-env -f $PROJECT_FOLDER/dependencies.nix -i ".*"
}

check_if_platform_supported
has_command nix-env || install_nix
install_dependencies
set_up_links

unset LC_ALL

