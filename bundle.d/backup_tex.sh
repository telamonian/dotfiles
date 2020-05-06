#!/usr/bin/env bash

# get the path to the manifest directory
THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
MANIFESTS="$THIS_DIR"/manifests

# list all installed TeX packages and save them in a manifest
tlmgr list --only-installed > "${MANIFESTS}/tex_manifest.tex"
