#!/usr/bin/env bash
## a script that re/create all of necessary links between ${HOME} and the dotfiles repo

# set this var for a dry-run or for a cleanup
# TODO: refactor into command line args
RUNTYPE=normal
#RUNTYPE=dryrun
#RUNTYPE=clean

# figure out the absolute path to the directory containing this script
reldir=$(dirname "$(stat -f "$0")")
absdir=$(cd $(dirname "${reldir}") && pwd -P)/$(basename "${reldir}")

# might be a better way of doing this, but for now we just cheat with pyton in order to get the relative path between the dotfiles (including this script) and ${HOME}
relpath=$(python -c "import os.path; print os.path.relpath(\"${absdir}\", \"${HOME}\")")

## loop through the array of dotfiles and create softlinks in ${HOME} pointing to them along relpath
for dotfileReal in ${absdir}/dotfile.d/.[!.]*; do
    dotfileName=$(basename $dotfileReal)

    if [ "$RUNTYPE" = dryrun ] ; then
        # dry run version
        echo "linking ${HOME}/$dotfileName -> ${relpath}/dotfile.d/$dotfileName"
        echo ln -s ${relpath}/dotfile.d/$dotfileName ${HOME}/$dotfileName
    elif [ "$RUNTYPE" = clean ] ; then
        echo "removing link at ${HOME}/$dotfileName"
        rm ${HOME}/$dotfileName
    else
        # normal version
        echo "linking ${HOME}/$dotfileName -> ${relpath}/dotfile.d/$dotfileName"
        ln -s ${relpath}/dotfile.d/$dotfileName ${HOME}/$dotfileName
    fi
done
