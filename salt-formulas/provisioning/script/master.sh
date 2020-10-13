#!/usr/bin/env sh

apt-get install salt-master -yqq
cp -v /tmp/master /etc/salt/master
systemctl restart salt-master
chown -R vagrant:vagrant /var/cache/salt/

sleep 10
salt-key -Ay
