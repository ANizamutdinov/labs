storage "consul" {
  address = "10.0.2.15:8500"
  path = "vault"
  token = "39c4337b-cbd8-310a-feac-b06ad9bd5f1e"
}
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = true
}
service_registration "consul" {
  address      = "10.0.2.15:8500"
  service_address = ""
  token = "39c4337b-cbd8-310a-feac-b06ad9bd5f1e"
}
ui = true
