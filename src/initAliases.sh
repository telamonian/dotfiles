#!/usr/bin/env bash
## a script that re/create all of necessary links between ${HOME} and the dotfiles repo
set -e

# set up command line parsing via getopts
# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [-cd]
Set up links between your {HOME} dir and the dotfiles in {DOT_HOME}

    -h    Display this help and exit.
    -d    Dry run. For debug purposes, echo commands instead of running them. Can also be used in conjunction with -r
    -r    Remove links. Instead of creating links, remove any existing links to dotfiles in {DOT_HOME}
EOF
}

# Initialize our own variables:
dryrun=false
remove=false

OPTIND=1
# Resetting OPTIND is necessary if getopts was used previously in the script.
# It is a good idea to make OPTIND local if you process options in a function.

while getopts hdr opt; do
    case $opt in
        h)
            show_help
            exit 0
            ;;
        d)  dryrun=true
            ;;
        r)  remove=true
            ;;
        *)
            show_help >&2
            exit 1
            ;;
    esac
done
shift "$((OPTIND-1))"   # Discard the options and sentinel --

# get some common directory paths (ABS_DOT_ROOT, DOT_HOME, etc.) from vars.sh
reldir=$(dirname "$(stat -f "${BASH_SOURCE}")")
source "${reldir}"/dotvars.sh

# might be a better way of doing this, but for now we just cheat with pyton in order to get the relative path between the dotfiles (including this script) and ${HOME}
relpath=$(python -c "from __future__ import print_function; import os.path; print(os.path.relpath(\"${ABS_DOT_ROOT}\", \"${HOME}\"))")

## loop through every file in {DOT_HOME} that starts with exactly one period...
#for dotfileReal in ${ABS_DOT_ROOT}/${DOT_HOME}/.[!.]*; do

## loop through every file in {DOT_HOME} and create softlinks in ${HOME} pointing to them along relpath
for dotfileReal in ${ABS_DOT_ROOT}/${DOT_HOME}/.[!.]*; do
    case $dotfilereal in
        # filter out any .swp files
        *.swp ) continue;;
    esac
    dotfileName=$(basename $dotfileReal)
    linkPath=${HOME}/$dotfileName
    targetPath=${relpath}/${DOT_HOME}/$dotfileName

    if [ "$remove" = true ] ; then
        echo "Removing link at $linkPath ..."

        if [ ! -L $linkPath ] ; then
            # link does not currently exist
            echo "... $linkPath does not exist, skipping."
        else
            # link currently exists
            if [ "$dryrun" = true ] ; then
                # dryrun version of remove
                echo rm $linkPath
            else
                # normal version of remove
                rm $linkPath
            fi

            echo "... done."
        fi
    else
        echo "Linking $linkPath -> $targetPath ..."

        if [ ! -L $linkPath ] ; then
            # link does not currently exist
            if [ "$dryrun" = true ] ; then
                # dryrun version of normal linking behavior
                echo ln -s $targetPath $linkPath
            else
                # normal version of normal linking behavior
                ln -s $targetPath $linkPath
            fi

            echo "... done."
        else
            # link currently exists
            echo "... $linkPath already exists, skipping."
        fi
    fi
done
