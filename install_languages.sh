#!/usr/bin/env bash

PROJECT_FOLDER=$(cd `dirname $0` && pwd)

nix-env -f $PROJECT_FOLDER/languages.nix -i ".*"
