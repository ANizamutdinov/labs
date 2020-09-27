#!/usr/bin/env bash

mkdir -p "/var/lib/consul/data"
chown -R vagrant:vagrant "/var/lib/consul"

mkdir -p "/etc/consul/consul.d"
chown -R vagrant:vagrant "/etc/consul"

cp -v /vagrant/provisioning/config/consul.service /etc/systemd/system/consul.service
sudo systemctl daemon-reload

cp -v /vagrant/provisioning/config/consul-agent.hcl /etc/consul/consul.hcl
cp -v /vagrant/provisioning/config/consul-acl.hcl /etc/consul/acl.hcl
sudo systemctl restart consul
