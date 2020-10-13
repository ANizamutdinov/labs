#!/usr/bin/env sh

export DEBIAN_FRONTEND=noninteractive

wget -qO - https://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo "deb http://repo.saltstack.com/py3/ubuntu/18.04/amd64/latest bionic main" > /etc/apt/sources.list.d/saltstack.list

apt-get update -qq && apt-get upgrade -yqq && apt-get autoremove -yq
apt-get install htop iftop tcpdump nload python3-pip tree -yq

echo 'alias python="python3"' >> .bashrc
echo 'alias pip="pip3"' >> .bashrc