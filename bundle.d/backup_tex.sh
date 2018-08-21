#!/usr/bin/env bash

# get the path to the manifest directory
MANIFESTS=$(cd "$(dirname "$(stat -f "${BASH_SOURCE}")")"/ && pwd -P)/manifests

# list all installed TeX packages and save them in a manifest
tlmgr list --only-installed > "${MANIFESTS}/tex_manifest.tex"