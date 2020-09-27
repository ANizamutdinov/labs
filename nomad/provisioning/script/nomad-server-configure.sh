#!/usr/bin/env bash

mkdir -p "/var/lib/nomad/data"
chown -R vagrant:vagrant "/var/lib/nomad"

mkdir -p "/etc/nomad/nomad.d"
chown -R vagrant:vagrant "/etc/nomad"

cp -v /vagrant/provisioning/config/nomad.service /etc/systemd/system/nomad.service
sudo systemctl daemon-reload

cp -v /vagrant/provisioning/config/nomad-server.hcl /etc/nomad/nomad.hcl
#cp -v /vagrant/provisioning/config/consul-acl.hcl /etc/consul/acl.hcl
sudo systemctl restart nomad

