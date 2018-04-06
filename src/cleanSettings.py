#!/usr/bin/env python
import os
import re
from six import print_

scriptPth = os.path.realpath(__file__)
settingsPth = os.path.realpath(os.path.join(scriptPth, '..', '..', 'setting.d'))
iterm2Pth = os.path.join(settingsPth, 'iterm2', 'com.googlecode.iterm2.plist')

def scrubLines(pth, pattern, n=1):
    """remove all lines matching pattern from the file at pth.
    If n > 1, remove each matching line and the  next n - 1 lines as well.
    """
    scrubRe = re.compile(pattern)

    lines = []
    with open(pth) as f:
        for line in f:
            if scrubRe.search(line):
                # skip this line and the next n - 1 lines
                for i in range(n - 1):
                    next(f)
            else:
                lines.append(line)

    with open(pth, 'w') as f:
        for line in lines:
            f.write(line)

def main():
    if os.path.exists(iterm2Pth):
        print_('Fixing iterm2 settings')
        scrubLines(iterm2Pth, 'NSWindow Frame iTerm Window', n=2)

if __name__=='__main__':
    main()
