#!/usr/bin/env bash

# get the path to the manifests directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MANIFESTS="$THIS_DIR"/manifests

# run the bundle cmd in the manifests dir
(cd $MANIFESTS && brew bundle)
