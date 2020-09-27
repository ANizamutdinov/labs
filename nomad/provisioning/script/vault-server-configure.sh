#!/usr/bin/env bash

mkdir -p /etc/vault

sudo cp -v /vagrant/provisioning/config/vault.service /etc/systemd/system/vault.service
sudo rm -f /etc/vault/vault.hcl
sudo cp -v /vagrant/provisioning/config/vault-node.hcl /etc/vault/vault.hcl

sudo chown -R vault:vault /etc/vault
sudo chmod 664 /etc/vault/vault.hcl

sudo systemctl daemon-reload
sudo systemctl restart vault
