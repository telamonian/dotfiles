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

# aliases for copying/downloading files
alias rget="wget -r --user tel --password ampzampz"
alias msync="rsync -avP --rsh=ssh"
alias msync_lm="msync -f\"+ */\" -f\"+ *.err\" -f\"+ *.lmint\" -f\"+ *.log\" -f\"+ *.sge\" -f\"+ *.slurm\"  -f\"- *\""
alias msync_marcc_lm="msync_marcc -f\"+ */\" -f\"- *.err\" -f\"- *.log\""

# alias for printing out octal permissions on the command line
alias octalperm="stat -f %Mp%Lp"

# aliases for setting up the named cmake builds
alias cmakedebug='cmake -DCMAKE_BUILD_TYPE=DEBUG'
alias cmakerelease='cmake -DCMAKE_BUILD_TYPE=RELEASE'

## aliases for docker shortcuts
# commands for building, initializing, starting, and attaching to docker containers
dcont_build_here()
{
    # build the Dockerfile in the current dir into an image named $1
    image_name=$1

    docker build . -t "${image_name}"
}

# remove all containers and images
alias dcont_clean='docker stop $(docker ps -a -q) && docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'

dcont_init()
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
