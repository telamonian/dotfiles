#!/usr/bin/env bash

# an array of all the dotfiles for which we want there to be soft links to in ${HOME}
declare -a dotfileArr=(
    ".bashrc"
    ".pythonstartup.py"
    ".tmux.conf"
    ".vim"
    ".vimrc"
)

## a script that re/create all of necessary links between ${HOME} and the dotfiles repo
reldir=$(dirname "$(stat -f "$0")")
absdir=$(cd $(dirname "${reldir}") && pwd -P)/$(basename "${reldir}")

# might be a better way of doing this, but for now we just cheat with pyton in order to get the relative path between the dotfiles (including this script) and ${HOME}
relpath=$(python -c "import os.path; print os.path.relpath(\"${absdir}\", \"${HOME}\")")

## loop through the array of dotfiles and create softlinks in ${HOME} pointing to them along relpath
for i in "${dotfileArr[@]}"
do
    ln -s ${relpath}/${i}

    # dry run version
    #echo ln -s ${relpath}/${i}
done

