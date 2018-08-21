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


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash