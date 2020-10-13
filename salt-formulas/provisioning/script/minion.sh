#!/usr/bin/env sh

apt-get install salt-minion -yqq
cp -v /tmp/minion /etc/salt/minion
systemctl restart salt-minion
