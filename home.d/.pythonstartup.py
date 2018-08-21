import sys
import io

import numpy as np
import os
from pathlib import Path

# define some setup functions
def _fixmanpager(auto=False):
    """If MANPAGER is set to the vim plugin manpager.vim, this screws up the builtin help(...) function when run in a shell (see pydoc.py and https://bugs.python.org/issue8637).
    """
    mp = 'MANPAGER'
    pp = 'PYDOCPAGER'

    # if PYDOCPAGER has been explicitly set, sub for MANPAGER
    if pp in os.environ:
        os.environ[mp] = os.environ[pp]

        return True
    elif mp in os.environ:
        # look for the word 'vim'
        vimix = os.environ[mp].find(' vim ')

        if vimix and os.environ[mp].find(mp):
            # if MANPAGER follows vim, assume manpager.vim is being used
            if auto:
                # set MANPAGER to pydocpager.vim
                os.environ[mp] = 'vim --not-a-term +PYDOCPAGER -'
            else:
                # just unset MANPAGER
                os.environ.pop(mp)

            return True
    else:
        return False

# run the setup functions
_fixmanpager(auto=False)

# cleanup any setup vars/funcs
del _fixmanpager
