#!/usr/bin/env bash
update_apt()
{
    add-apt-repository ppa:brightbox/ruby-ng-experimental
    apt-get update
}

install_apt_pkg()
{
    apt-get install -y curl file g++ git make libxml-parser-perl libxml-sax-perl openssh-server ruby2.0 ruby2.0-dev uuid-runtime vim wbritish
    ln -sf ruby2.0 /usr/bin/ruby
    ln -sf gem2.0 /usr/bin/gem
}

remove_apt_pkg()
{
    DEBIAN_FRONTEND=noninteractive sudo apt-get autoremove -y --purge libblas-dev libbz2-dev libexpat1-dev libfreetype6-dev libgl1-mesa-dev libgdbm-dev libicu-dev libidn11-dev libjack-dev libjack-jackd2-0 libjack-jackd2-dev libjack0 libjasper-dev libjbig-dev libkrb5-dev liblapack-dev liblzma-dev libncurses5-dev libopenblas-dev libpcre3-dev libpq-dev libtinfo-dev libwebp-dev libwmf-dev libx11-dev libxml2-dev llvm-3.5 llvm-3.6 llvm-3.7 llvm-3.8 llvm-3.9 llvm-4.0 mysql-common zlib1g-dev
}

# install some packages linuxbrew needs, remove ones it doesn't
update_apt
install_apt_pkg
remove_apt_pkg