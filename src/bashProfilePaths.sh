#!/usr/bin/env bash
# vim: ft=bash

###############################################################################
####  _               _                          __         _   _          ####
#### | |             | |                        / _|       | | | |         ####
#### | |__   __ _ ___| |__      _ __  _ __ ___ | |_   _ __ | |_| |__  ___  ####
#### | '_ \ / _` / __| '_ \    | '_ \| '__/ _ \|  _| | '_ \| __| '_ \/ __| ####
#### | |_) | (_| \__ \ | | |   | |_) | | | (_) | |   | |_) | |_| | | \__ \ ####
#### |_.__/ \__,_|___/_| |_|   | .__/|_|  \___/|_|   | .__/ \__|_| |_|___/ ####
####                     ______| |             ______| |                   ####
####                    |______|_|            |______|_|                   ####
###############################################################################
# This file holds one function: bashProfilePaths, which gives the paths of
# bash source files that should be sourced by .bash_profile on terminal
# start up.


# $_ stores invoke path OR last argument to the previous command
INVOKE_PATH="$_"

if [ -z "$DOT_REPO" ]; then echo "DOT_REPO not defined" >&2; exit 1; fi

# test if this file is being sourced.
if [ "${INVOKE_PATH}" != "${BASH_SOURCE[0]}" ]; then
    issoucred=true
else
    issourced=false
fi

source "$DOT_REPO"/src/dotvars.sh
_PROFILE_D="$DOT_REPO"/"$DOT_BASH"

bashProfilePaths()
{
    for bashsrc in "$_PROFILE_D"/.bash_*; do
        case "$bashsrc" in
            *.swp ) continue;;
            * ) echo "$bashsrc";;
        esac
    done
}

# if the file is not being sourced, run bashProfilePaths now
if [ "$issourced" = false ]; then
    bashProfilePaths
fi
