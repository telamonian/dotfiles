#!/usr/bin/env bash

## run this when the "open with" submenu in finder's right-click context menu fills up with garbage (for reason still unknown)
##
## refs:
## https://apple.stackexchange.com/a/66870
## https://apple.stackexchange.com/a/204845

/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

