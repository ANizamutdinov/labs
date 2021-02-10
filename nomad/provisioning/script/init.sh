#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive
echo "set grub-pc/install_devices /dev/sda" | debconf-communicate
wget -qO - https://apt.releases.hashicorp.com/gpg | apt-key add -
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashi.list
apt-get -qq update
apt-get -qqy upgrade
apt-get -qqy install curl htop iftop tcpdump unzip dnsutils jq consul vault nomad