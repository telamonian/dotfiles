#!/usr/bin/env bash
# remove .DS_Store (if it exists) from this directory and any subdirectories
# modified from https://stackoverflow.com/a/107921/425458

FNAME=".DS_Store"
RMEXE=rm
#RMEXE=git rm -f --ignore-unmatch

find . -name $FNAME -print0 | xargs -0I{} bash -c "ls {} && ${RMEXE} {}"
