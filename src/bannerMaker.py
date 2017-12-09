#!/usr/bin/env python3
from copy import deepcopy
from pyfiglet import Figlet
import os,sys


class BannerMaker(object):
    """A version of my old BannerAdorner obj/script.
    Upgraded with pyfiglet, so now it makes the text and adornment (eg the '*' wrapping) all in one go
    """
    fillChar = '#'
    fillWidth = 4
    sepChar = ' '
    sepWidth = 1

    def __init__(self, text=None, fillChar=None, fillWidth=None, sepChar=None, sepWidth=None):
        if fillChar is not None:
            self.fillChar = fillChar
        if fillWidth is not None:
            self.fillWidth = fillWidth
        if sepChar is not None:
            self.sepChar = sepChar
        if sepWidth is not None:
            self.sepWidth = sepWidth
        
        if text is None:
            # no text -> empty string
            self.bannerLinesOriginal = ['']
        else:
            # convert text to awesome/cool ascii bubble letters! make sure to split this into a list of line. Prune any empty or all whitespace lines
            self.bannerLinesOriginal = [line for line in Figlet(font='big').renderText(text).split('\n') if line and not line.isspace()]
        
        # prep for wrapping the text in a bunch of "*" (in order to make a propper banner, of course)
        self.initBannerLines()
    
    def __str__(self):
        return '\n'.join(self.bannerLines)

    def initBannerLines(self):
        self.bannerLines = deepcopy(self.bannerLinesOriginal)

    def sanitize(self):
        for i,line in enumerate(self.bannerLines):
            self.bannerLines[i] = line.strip('\n')
    
    def addSep(self):
        sepBlock = self.sepChar*self.sepWidth
        for i,line in enumerate(self.bannerLines):
            self.bannerLines[i] = '%s%s%s' % (sepBlock, line, sepBlock)

    def addFill(self):
        fillBlock = self.fillChar*self.fillWidth
        for i,line in enumerate(self.bannerLines):
            self.bannerLines[i] = '%s%s%s' % (fillBlock, line, fillBlock)
        self.bannerLines = [self.fillChar*len(self.bannerLines[0])] + self.bannerLines
        self.bannerLines = self.bannerLines + [self.fillChar*len(self.bannerLines[-1])]
        
    def adorn(self):
        #self.sanitize()
        self.addSep()
        self.addFill()

if __name__=='__main__':
    # if multiple args are passed to this script, join them into a single string separated by spaces
    text = ' '.join(sys.argv[1:])
    
    bannerMaker = BannerMaker(text=text)
    bannerMaker.adorn()
    print(bannerMaker)
