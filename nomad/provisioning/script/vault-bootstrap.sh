#!/usr/bin/env bash

export VAULT_ADDR=http://10.0.2.15:8200
VAULT_INIT=$(vault operator init -n 3 -t 2)

VAULT_UNSEAL1=$(echo ${VAULT_INIT} | grep "Unseal Key 1:" | cut -d " " -f 4 | sed -e 's/^[[:space:]]*//' )
VAULT_UNSEAL2=$(echo ${VAULT_INIT} | grep "Unseal Key 2:" | cut -d " " -f 8 | sed -e 's/^[[:space:]]*//' )
VAULT_UNSEAL3=$(echo ${VAULT_INIT} | grep "Unseal Key 3:" | cut -d " " -f 12 | sed -e 's/^[[:space:]]*//' )
VAULT_ROOT=$(echo ${VAULT_INIT} | grep "Initial Root Token:" | cut -d " " -f 16 | sed -e 's/^[[:space:]]*//' )

echo ${VAULT_ROOT} > /vagrant/provisioning/config/vault_root_token;

echo "#!/usr/bin/env bash"                      > /vagrant/provisioning/script/vault-unseal.sh
echo "export VAULT_ADDR=http://10.0.2.15:8200" >> /vagrant/provisioning/script/vault-unseal.sh
echo "vault operator unseal ${VAULT_UNSEAL1}"  >> /vagrant/provisioning/script/vault-unseal.sh
echo "vault operator unseal ${VAULT_UNSEAL2}"  >> /vagrant/provisioning/script/vault-unseal.sh
