disable_mlock = true

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_client_ca_file = "/Users/zeus/www/gigster/vault-deployment/vault/newCa/ca.pem"
  tls_cert_file = "/Users/zeus/www/gigster/vault-deployment/vault/newCa/vault-combined.pem"
  tls_key_file = "/Users/zeus/www/gigster/vault-deployment/vault/newCa/vault-key.pem"
}

storage "consul" {
  address = "127.0.0.1:8500"
  path = "vault/"
}