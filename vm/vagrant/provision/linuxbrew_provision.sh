#!/usr/bin/env bash
install_apt_pkg()
{
    apt-get update
    apt-get install -y curl file g++ git make libxml-parser-perl libxml-sax-perl openssh-server ruby2.0 ruby2.0-dev uuid-runtime vim
    ln -sf ruby2.0 /usr/bin/ruby
    ln -sf gem2.0 /usr/bin/gem
}

remove_apt_pkg()
{
    DEBIAN_FRONTEND=noninteractive sudo apt-get autoremove -y --purge libblas-dev libbz2-dev libexpat1-dev libfreetype6-dev libgl1-mesa-dev libgdbm-dev libicu-dev libidn11-dev libjack-dev libjack-jackd2-0 libjack-jackd2-dev libjack0 libjasper-dev libjbig-dev libkrb5-dev liblapack-dev liblzma-dev libncurses5-dev libopenblas-dev libpcre3-dev libpq-dev libtinfo-dev libwebp-dev libwmf-dev libx11-dev libxml2-dev llvm-3.4 mysql-common zlib1g-dev
}

create_brew_user()
{
    localedef -i en_US -f UTF-8 en_US.UTF-8
    id -u linuxbrew || useradd -m -s /bin/bash linuxbrew
    grep -q -F 'linuxbrew ALL=(ALL) NOPASSWD:ALL' /etc/sudoers || echo 'linuxbrew ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

    # add an .ssh dir if one does not exist
    if [ ! -d /home/linuxbrew/.ssh ]; then
        cp /home/vagrant/.ssh/authorized_keys /home/linuxbrew/.ssh
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

# install some packages linuxbrew needs, remove ones it doesn't
install_apt_pkg
remove_apt_pkg

# create the linuxbrew user if they don't already exist
create_brew_user

# set up the paths needed by brew
SET_BREW_PATH='PATH=/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH'
sudo -u linuxbrew bash -c "grep -q -F '${SET_BREW_PATH}' /home/linuxbrew/.profile || echo '${SET_BREW_PATH}' >> /home/linuxbrew/.profile"
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