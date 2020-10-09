#!/usr/bin/env bash

export VAULT_ADDR=http://10.0.2.15:8200
export VAULT_TOKEN=$(cat /vagrant/provisioning/config/vault_root_token)

# Write the policy to Vault
vault policy write nomad-server /vagrant/provisioning/config/vault-policy-nomad.hcl

# Create the token role with Vault
vault write /auth/token/roles/nomad-cluster @/vagrant/provisioning/config/vault-role-nomad.json

# Create the token for nomad servers
CREATE_NOMAD_TOKEN_TO_VAULT=$(vault token create -policy nomad-server -period 72h -orphan)
NOMAD_TOKEN_TO_VAULT=$(echo "${CREATE_NOMAD_TOKEN_TO_VAULT}" | grep "token " | tr -s ' ' | cut -d " " -f 2)

sed -i "s/token\ =\ .*Vault/token\ =\ \"${NOMAD_TOKEN_TO_VAULT}\" # Vault/g" /vagrant/provisioning/config/nomad-server.hcl
