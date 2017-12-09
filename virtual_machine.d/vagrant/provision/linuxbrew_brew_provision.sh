#!/usr/bin/env bash

# the user from whom to copy the .ssh setup
sshuser=$1

create_brew_user()
{
    localedef -i en_US -f UTF-8 en_US.UTF-8
    id -u linuxbrew || useradd -m -s /bin/bash linuxbrew
    grep -q -F 'linuxbrew ALL=(ALL) NOPASSWD:ALL' /etc/sudoers || echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

    # add an .ssh dir if one does not exist
    if [ ! -d /home/linuxbrew/.ssh ]; then
        cp -r /home/${sshuser}/.ssh /home/linuxbrew
    fi
    chown -R linuxbrew: /home/linuxbrew/.ssh
}

# doesn't work with sudo -u
setup_brew_path()
{
    SET_BREW_PATH='PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH'
    grep -q -F '${SET_BREW_PATH}' /home/linuxbrew/.profile || echo '${SET_BREW_PATH}' >> /home/linuxbrew/.profile
}
export -f setup_brew_path

# doesn't work with sudo -u
setup_brew()
{
    if [ -d /home/linuxbrew/.linuxbrew ]; then
        sudo chown -R linuxbrew: /home/linuxbrew/.linuxbrew
    fi
    git clone https://github.com/Homebrew/linuxbrew.git /home/linuxbrew/.linuxbrew

    brew update
    brew tap linuxbrew/xorg
}
export -f setup_brew

# create the linuxbrew user if they don't already exist
create_brew_user

# set up the paths needed by brew
SET_BREW_PATH='PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH'
sudo -u linuxbrew bash -c "grep -q -F '${SET_BREW_PATH}' /home/linuxbrew/.profile || echo '${SET_BREW_PATH}' >> /home/linuxbrew/.profile"

# other env
SET_EDITOR="export EDITOR='vim'"
sudo -u linuxbrew bash -c "grep -q -F '${SET_EDITOR}' /home/linuxbrew/.profile || echo '${SET_EDITOR}' >> /home/linuxbrew/.profile"
#sudo -Hi -u linuxbrew bash -c "echo 'SHELL=/bin/bash' >> /home/linuxbrew/.profile

# set up the actual brew files
if [ -d /home/linuxbrew/.linuxbrew ]; then
    echo "/home/linuxbrew/.linuxbrew exists, ensuring correct permissions."
    chown -R linuxbrew: /home/linuxbrew/.linuxbrew
fi

# -H for setting up $HOME, -i for sourcing .bashrc, etc., -u for user
sudo -Hi -u linuxbrew bash -c 'git clone https://github.com/Homebrew/linuxbrew.git /home/linuxbrew/.linuxbrew'

sudo -Hi -u linuxbrew bash -c 'brew update'
sudo -Hi -u linuxbrew bash -c 'brew tap linuxbrew/xorg'