#!/usr/bin/env bash

# get the path to the manifests directory
MANIFESTS=$(cd "$(dirname "$(stat -f "${BASH_SOURCE}")")"/ && pwd -P)/manifests

# run the bundle cmd in the manifests dir
(cd $MANIFESTS && brew bundle)