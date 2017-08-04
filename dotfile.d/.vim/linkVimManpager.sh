#!/usr/bin/env bash

# pass your vim executable of choice as the first arg. Defaults to just "vim"
if [ -z ${1+x} ]; then 
    # no arg passed, just use "vim"
    vim_exec="vim"
else
    vim_exec=$1
fi

# figure out the location of your vim's root plugin dir
vim_root_plugindir=$(${vim_exec} -e -T dumb --cmd 'exe "set t_cm=\<C-M>"|echo $VIMRUNTIME|quit' | tr -d '\015')

# some plugin file paths
manvim_relpath=ftplugin/man
manpagervim_relpath=plugin/manpager

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

