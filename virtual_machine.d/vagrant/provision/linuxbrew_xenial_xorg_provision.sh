#!/usr/bin/env bash
update_apt()
{
    apt-get update
}

install_apt_pkg()
{
    sudo apt install freeglut3 libgl1-mesa-glx libglew1.13 libglu1-mesa xserver-xorg-core
}

remove_apt_pkg()
{
    DEBIAN_FRONTEND=noninteractive sudo apt-get autoremove -y --purge freeglut3 libgl1-mesa-glx libglew1.13 libglu1-mesa xserver-xorg-core
}

# install some packages linuxbrew needs, remove ones it doesn't
update_apt
install_apt_pkg