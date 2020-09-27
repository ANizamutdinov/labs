#!/usr/bin/env bash

export CONSUL_HTTP_ADDR=10.0.2.15:8500
CONSUL_MGMT_TOKEN=$( consul acl bootstrap | grep SecretID | cut -d ":" -f 2 | sed -e 's/^[[:space:]]*//' )


consul acl policy create -token=${CONSUL_MGMT_TOKEN} -name node-policy -rules @/vagrant/provisioning/config/policy-node.hcl
CONSUL_NODE_TOKEN_OUTPUT=$(consul acl token create -token=${CONSUL_MGMT_TOKEN} -description "Consul-server token" -policy-name node-policy)
CONSUL_NODE_TOKEN=$(echo ${CONSUL_NODE_TOKEN_OUTPUT} | grep SecretID | cut -d " " -f 4 | sed -e 's/^[[:space:]]*//' )

echo "#!/usr/bin/env bash"                                                                > /vagrant/provisioning/script/consul-set-node-token.sh
echo "export CONSUL_HTTP_ADDR=10.0.2.15:8500"                                            >> /vagrant/provisioning/script/consul-set-node-token.sh
echo "consul acl set-agent-token -token=${CONSUL_MGMT_TOKEN} agent ${CONSUL_NODE_TOKEN}" >> /vagrant/provisioning/script/consul-set-node-token.sh


consul acl policy create -token=${CONSUL_MGMT_TOKEN} -name vault-policy -rules @/vagrant/provisioning/config/policy-vault.hcl
VAULT_NODE_TOKEN_OUTPUT=$(consul acl token create -token=${CONSUL_MGMT_TOKEN} -description "Vault-server token" -policy-name vault-policy)
VAULT_NODE_TOKEN=$(echo ${VAULT_NODE_TOKEN_OUTPUT} | grep SecretID | cut -d " " -f 4 | sed -e 's/^[[:space:]]*//' )

sed -i "s/token\ =\ .*/token\ =\ \"${VAULT_NODE_TOKEN}\"/g" /vagrant/provisioning/config/vault-node.hcl
sed -i "s/token\ =\ .*/token\ =\ \"${CONSUL_NODE_TOKEN}\"/g" /vagrant/provisioning/config/nomad-server.hcl
