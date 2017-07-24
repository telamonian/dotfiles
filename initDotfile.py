#!/usr/bin/env python
import os,sys

from bannerMaker import BannerMaker

## initializes a dotfile, including a filetype=bash modeline for vim and an optional banner
    # the name of the dotfile is the first argument passed, and the path is automatically determined from the location of this script
    # a fancy ascii art banner can be added to the top of the new dotfile by passing the desired text as an (optional) second argument

def main():
    # the vim modeline that we'll stick at the top of the file to ensure proper syntax highlighting regardless of file extension
    modeline = '# vim: ft=bash\n'

    # the real path to this script. Thus it should always remain at the toplevel of the dotfile repo
    dotfilesPath = os.path.dirname(os.path.realpath(__file__))
    initPath = os.path.join(dotfilesPath, sys.argv[1])
    
    # don't allow overwriting of existing dotfile (for now don't allow any overwriting at all, may be relaxed in future)
    if os.path.isfile(initPath) || os.path.isdir():
        raise ValueError("dotfile at: %s already exists!" % initPath)

    dotfile = open(m, 'w')
    dotfile.write(modeline)
    
    # make a banner at the top of the new dotfile if requested
    if len(sys.argv) > 2:
        # the script has been passed at least two args. Make a banner from the second arg and (for now) ignore the rest
        bannerMaker = BannerMaker(test=sys.argv[2])
        bannerMaker.adorn()
        dotfile.write('%s' % bannerMaker)

if __name__=='__main__':
    main()
