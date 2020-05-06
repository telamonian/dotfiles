#!/usr/bin/env bash

# get the path to the manifests directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MANIFESTS="$THIS_DIR"/manifests

# run the pip freeze cmd for python 2
echo "Creating package manifest for Python 2..."
pip2 freeze > "${MANIFESTS}/py2_manifest.txt"
echo "...done"

# run the pip freeze cmd for python 3
echo "Creating package manifest for Python 3..."
pip3 freeze > "${MANIFESTS}/py3_manifest.txt"
echo "...done"
