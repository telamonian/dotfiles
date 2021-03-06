# vim: ft=bash

##########################################
#####        _ _                     #####
#####       | (_)                    #####
#####   __ _| |_  __ _ ___  ___  ___ #####
#####  / _` | | |/ _` / __|/ _ \/ __|#####
##### | (_| | | | (_| \__ \  __/\__ \#####
#####  \__,_|_|_|\__,_|___/\___||___/#####                                
##########################################
#### general purpose aliases

# aliases for listing files
alias lsdot="ls -d .[!.]*"

# aliases for navigating dirs
alias pd="pushd"

# aliases for copying/downloading files
alias rget="wget -r --user tel --password ampzampz"
alias msync="rsync -avP --rsh=ssh"
alias msync_lm="msync -f\"+ */\" -f\"+ *.err\" -f\"+ *.lmint\" -f\"+ *.log\" -f\"+ *.sge\" -f\"+ *.slurm\"  -f\"- *\""
alias msync_marcc_lm="msync_marcc -f\"+ */\" -f\"- *.err\" -f\"- *.log\""

# aliases for setting up the named cmake builds
alias cmakedebug='cmake -DCMAKE_BUILD_TYPE=DEBUG'
alias cmakerelease='cmake -DCMAKE_BUILD_TYPE=RELEASE'

## aliases for docker shortcuts
# commands for building, initializing, starting, and attaching to docker containers
dock_build()
{
    # build the Dockerfile in the current dir into an image named $1
    image_name=$1

    docker build . -t "${image_name}"
}

# remove all containers and images
alias dock_clean='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

dock_init()
{
    # start and join a docker container named $2 using image $1 
    image_name=$1
    container_name=$2

    docker run -it --rm -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix
}

## aliases for docker-machine shortcuts
# login-to-login persistent docker machine start and stop
alias dmachine_start='brew services start docker-machine'
alias dmachine_stop='brew services stop docker-machine'

# for launching the dmachine itself
alias dmachine_vbox='docker-machine create --driver virtualbox docker-vm'

# for setting up a shell env to interact with the docker cmd line program
alias dmachine_env='eval "$(docker-machine env docker-vm)"'

# for disabling/reenabling spotlight on a mac
alias disable_spotlight='sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'
alias enable_spotlight='sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist'

## aliases for jupyterlab development
# stash changes to build system before commit
alias jlab_stash='git stash push -- *.config.js tsconfigbase.json'

### homebrew-specific aliases for running versioned python commands
## run old python
#alias python@2='$(brew --prefix python@2)/bin/python2'
#alias pip@2='python@2 -m pip'
#
## run python
#alias python@3.7='$(brew --prefix python@3.7)/bin/python3'
#alias python@3.8='$(brew --prefix python@3.8)/bin/python3'
#alias python@3.9='$(brew --prefix python@3.9)/bin/python3'
#alias python@3='python@3.9'
#
## run pip
#alias pip@3.7='python@3.7 -m pip'
#alias pip@3.8='python@3.8 -m pip'
#alias pip@3.9='python@3.9 -m pip'
#alias pip@3='pip@3.9'

