#!/usr/bin/env bash

vagrant up
vagrant provision --provision-with consul_config
vagrant provision --provision-with consul_bootstrap
vagrant provision --provision-with consul_set_token
vagrant provision --provision-with vault_config
vagrant provision --provision-with vault_bootstrap
vagrant provision --provision-with vault_unseal
vagrant provision --provision-with nomad_config
