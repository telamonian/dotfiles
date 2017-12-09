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


# test if this file is being sourced.
if [ "$_" != "$0" ]; then
    issoucred=true
else
    issourced=false
fi

reldir=$(dirname "$(stat -f "${BASH_SOURCE}")")
source "${reldir}"/dotvars.sh

bashProfilePaths()
{
    for bashsrc in "${absdotdir}"/bash_profile.d/.bash_*; do
        case "${bashsrc}" in
            *.swp ) continue;;
            * ) echo "${bashsrc}";;
        esac
    done
}

# if the file is not being sourced, run bashProfilePaths now
if [ "$issourced" = false ]; then
    bashProfilePaths
fi

