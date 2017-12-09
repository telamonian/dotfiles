# vim: ft=bash

##########################################
####  _               _               ####
#### | |             | |              ####
#### | |__   __ _ ___| |__  _ __ ___  ####
#### | '_ \ / _` / __| '_ \| '__/ __| ####
#### | |_) | (_| \__ \ | | | | | (__  ####
#### |_.__/ \__,_|___/_| |_|_|  \___| ####
##########################################
#### Setup (possibly redundantly) some shell history file length/size stuff
#### Ensures that shell startup is consistent across login vs non and interactive vs non shells, preventing unwanted trncation of ${HOME}/.bash_hist.

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=1000000

