datacenter = "nvc"
data_dir = "/var/lib/nomad/data"
bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"192.168.0.0/16\" | attr \"address\" }}"

addresses {
  http = "10.0.2.15"
}

server {
  enabled = true
  bootstrap_expect = 3
  encrypt = "8Mcu+TLHtvEB5dMuGs1HGQ=="
}

consul {
  address = "10.0.2.15:8500"
  token = "72cbd129-7898-8caf-3617-adffdb292051" # Consul
}

vault {
  enabled = true
  address = "http://10.0.2.15:8200"
  token = "s.ps4FEPkyKpHKXTs6RR8osXae" # Vault
  create_from_role = "nomad-cluster"
}
