datacenter = "nvc"
bootstrap_expect = 3
server = true
encrypt = "tueum6QMFx2TV4G4m4fGXjkr8O3Xp6+/IQDYt3O1v8M="
data_dir = "/var/lib/consul/data"
ui = true
bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"192.168.0.0/16\" | attr \"address\" }}"
addresses = {
  http = "10.0.2.15"
}
ports = {
  http = 8500
}
start_join = ["192.168.42.21", "192.168.42.22", "192.168.42.23", "192.168.42.24", "192.168.42.25"]
log_level = "INFO"
