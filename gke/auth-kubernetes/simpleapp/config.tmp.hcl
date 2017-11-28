secret {
    no_prefix = true
    path = "secret/gigs/${APP_NAME}/${APP_ENV}"
}

upcase = true
pristine = true

vault {
    address = "https://${VAULT_SERVICE_HOST}:${VAULT_SERVICE_PORT}"
    renew_token = false

    ssl {
    enabled = true
    verify  = false
    }
}