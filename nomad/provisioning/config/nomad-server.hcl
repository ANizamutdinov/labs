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
  address      = "10.0.2.15:8500"
  token = "9c952c2a-7775-527e-a21c-4af42f73ee75"
}
