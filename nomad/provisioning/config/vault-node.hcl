storage "consul" {
  address = "10.0.2.15:8500"
  path = "vault"
  token = "d5883e30-2ddc-fd7d-453b-56c2138e26d4"
}
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable   = true
}
service_registration "consul" {
  address      = "10.0.2.15:8500"
  service_address = ""
  token = "d5883e30-2ddc-fd7d-453b-56c2138e26d4"
}
ui = true
