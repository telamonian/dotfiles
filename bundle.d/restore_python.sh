#!/usr/bin/env bash

# get the path to the manifests directory
MANIFESTS=$(cd "$(dirname "$(stat -f "${BASH_SOURCE}")")"/ && pwd -P)/manifests

# run the pip install cmd for python 2
echo "Restoring Python 2 packages from manifest..."
pip2 install -r "${MANIFESTS}/py2_manifest.txt"
echo "...done"

# run the pip install cmd for python 3
echo "Restoring Python 3 packages from manifest..."
pip3 install -r "${MANIFESTS}/py3_manifest.txt"
echo "...done"

