#!/usr/bin/env python3
import os,sys
from pathlib import Path
import re

DIR = 1
FILE = 2

class Renamer(object):
    """Walks along the tree pointed to by self.rootPath and renames files using re.sub(self.matchPattern,self.replacePatten,<filename>).
    """
    walkTupIndex = None

    @property
    def rootPathStr(self):
        return str(self.rootPath)

    def __init__(self, rootPath, matchPattern=None, replacePattern=None):
        self.rootPath = Path(rootPath)
        self.matchPattern = matchPattern
        self.replacePattern = replacePattern
        self.regex = re.compile(self.matchPattern)
    
    def rename(self, doTest=False):
        walker = os.walk(self.rootPathStr)
        for dirPath,tup in ((Path(tups[0]),tups[self.walkTupIndex]) for tups in walker):
            for name in tup:
                if self.regex.search(name):
                    newName = self.regex.sub(self.replacePattern, name)
                    print('%s >> %s' % (dirPath / name, dirPath / newName))
                    if not doTest:
                        (dirPath / name).rename(dirPath / newName)

class DirRenamer(Renamer):
    walkTupIndex = DIR

class FileRenamer(Renamer):
    walkTupIndex = FILE

if __name__=='__main__':
    '''
    example usage:

    ./renamer.py dir genetic_toggle_switch_test_data '([^\W\d_]+)([\d\.]+)_([^\W\d_]+)([\d\.]+)' '\1_\2_-_\3_\4' test
    '''
    renamerTypeName = sys.argv[1].strip()
    rootPath = sys.argv[2].strip()
    matchPattern = sys.argv[3]
    replacePattern = sys.argv[4]

    try:
        doTest = sys.argv[5]
    except IndexError:
        doTest = False

    if renamerTypeName=='dir':
        RenamerType = DirRenamer
    elif renamerTypeName=='file':
        ReanmerType = FileRenamer
    
    renamer = RenamerType(rootPath=rootPath, matchPattern=matchPattern, replacePattern=replacePattern)
    
    if doTest:
        print('renamerTypeName: %s' % renamerTypeName)
        print('rootPath: %s' % rootPath)
        print('matchPattern: %s' % matchPattern)
        print('replacePattern: %s' % replacePattern)

        renamer.rename(doTest=True)
    else:
        renamer.rename()
