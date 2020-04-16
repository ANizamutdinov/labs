# Increase log verbosity
log_level = "DEBUG"

# Setup data dir
data_dir = "/opt/nomad"

bind_addr = "0.0.0.0"
advertise {
  http = "10.0.2.15"
  rpc  = "{{ GetInterfaceIP  \"eth1\" }}"
  serf = "{{ GetInterfaceIP  \"eth1\" }}"
}

# Enable the server
server {
  enabled = true
  # Self-elect, should be 3 or 5 for production
  bootstrap_expect = 3
  server_join {
    retry_join = [
      "192.168.42.121",
      "192.168.42.122",
      "192.168.42.123"
    ]
    retry_max = 3
    retry_interval = "15s"
  }
}

client {
  enabled = true
  server_join {
    retry_join = [
      "192.168.42.121",
      "192.168.42.122",
      "192.168.42.123"
    ]
    retry_max = 3
    retry_interval = "15s"
  }
}
