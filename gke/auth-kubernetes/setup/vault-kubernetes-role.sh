#!/bin/bash

vault write auth/kubernetes/role/vault \
    bound_service_account_names=vault-auth \
    bound_service_account_namespaces=default \
    policies=vault-k8s \
    ttl=1h