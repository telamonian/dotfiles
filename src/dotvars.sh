#!/usr/bin/env bash
# some common vars used by several bash files in this package

absdotdir=$(cd "$(dirname "$(stat -f "${BASH_SOURCE}")")"/.. && pwd -P)
