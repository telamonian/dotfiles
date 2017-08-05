# vim: ft=bash

##########################################
#####        _ _                     #####
#####       | (_)                    #####
#####   __ _| |_  __ _ ___  ___  ___ #####
#####  / _` | | |/ _` / __|/ _ \/ __|#####
##### | (_| | | | (_| \__ \  __/\__ \#####
#####  \__,_|_|_|\__,_|___/\___||___/#####                                
##########################################
# general purpose aliases

alias rget="wget -r --user tel --password ampzampz"
alias msync="rsync -avP --rsh=ssh"
alias msync_lm="msync -f\"+ */\" -f\"+ *.err\" -f\"+ *.lmint\" -f\"+ *.log\" -f\"+ *.sge\" -f\"+ *.slurm\"  -f\"- *\""

# alias for printing out octal permissions on the command line
alias octalperm="stat -f %Mp%Lp"

# aliases for setting up the named cmake builds
alias cmakedebug='cmake $1 -DCMAKE_BUILD_TYPE=DEBUG'
alias cmakerelease='cmake $1 -DCMAKE_BUILD_TYPE=RELEASE'

## aliases for docker shortcuts
# login-to-login persistent docker machine start and stop
alias dmachine_start='brew services start docker-machine'
alias dmachine_stop='brew services stop docker-machine'

# for launching the dmachine itself
alias dmachine_vbox='docker-machine create --driver virtualbox docker-vm'
