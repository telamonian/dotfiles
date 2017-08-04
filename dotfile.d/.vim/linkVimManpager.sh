#!/usr/bin/env bash

manvim_relpath=ftplugin/man
manpagervim_relpath=plugin/manpager

# should be something along the lines of ${path-to-vim-install}/share/vim/vim80
vim_root_plugindir=$1

# figure out the absolute path to the directory containing this script (which should also be the .vim dir)
relthisdir=$(dirname "$(stat -f "$0")")
absthisdir=$(cd $(dirname "${reldir}") && pwd -P)/$(basename "${reldir}")

for relpath in ${manvim_relpath} ${manpagervim_relpath}; do
    abspath=${vim_root_plugindir}/${relpath}

    # move any existing *.vim files out of the way
    if [ -L ${abspath}.vim ]; then
        # if the file has already been replaced with a link, just remove it
        rm ${abspath}.vim
    else
        # assume this is still the original *.vim file, rename it to *.orig
        mv ${abspath}.vim ${abspath}.orig
    fi

    # make the needed symlink
    ln -s ${absthisdir}/${relpath}.vim  ${abspath}.vim
done

