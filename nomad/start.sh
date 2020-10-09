#!/usr/bin/env bash

vagrant up
sleep 10
vagrant provision --provision-with consul_bootstrap
sleep 10
vagrant provision --provision-with consul_set_token
sleep 10
vagrant provision --provision-with vault_config
sleep 10
vagrant provision --provision-with vault_bootstrap
sleep 10
vagrant provision --provision-with vault_unseal
sleep 10
vagrant provision --provision-with vault_set_nomad_access
sleep 10
vagrant provision --provision-with nomad_config
