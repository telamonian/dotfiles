import numpy as np
import os
import sys

# if MANPAGER is set to the vim plugin manpager.vim, this screws up the builtin help(...) function when run in a shell (see pydoc.py and https://bugs.python.org/issue8637)
def _fixmanpager():
    # look for the word 'vim'
    vimix = os.environ['MANPAGER'].find(' vim ')

    if vimix and os.environ['MANPAGER'].find('MANPAGER'):
        # if MANPAGER follows vim, assume manpager.vim is being used, unset MANPAGER
        os.environ.pop('MANPAGER')

        return True
    else:
        return False

_fixmanpager()

# cleanup any setup vars/funcs
del _fixmanpager
