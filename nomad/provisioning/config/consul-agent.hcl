datacenter = "nvc"
server = false
encrypt = "tueum6QMFx2TV4G4m4fGXjkr8O3Xp6+/IQDYt3O1v8M="
data_dir = "/var/lib/consul/data"
ui = false
bind_addr = "{{ GetPrivateInterfaces | include \"network\" \"192.168.0.0/16\" | attr \"address\" }}"
addresses = {
  http = "127.0.0.1"
}
ports = {
  http = 8500
}
start_join = ["192.168.1.21", "192.168.1.22", "192.168.1.23", "192.168.1.24", "192.168.1.25"]
log_level = "INFO"
