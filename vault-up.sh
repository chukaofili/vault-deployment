#!/bin/bash

deploy_consul() {
    echo "Configuring Consul..."
    kubectl apply -f ./consul/services/consul.yaml
    GOSSIP_ENCRYPTION_KEY=$(consul keygen)
    kubectl create -n $namespace secret generic consul \
        --from-literal="gossip-encryption-key=${GOSSIP_ENCRYPTION_KEY}" \
        --from-file=./vault/ca/ca.pem \
        --from-file=./vault/ca/vault.pem \
        --from-file=./vault/ca/vault-key.pem
    kubectl apply -f ./consul/configmap.yaml
    kubectl apply -f ./consul/statefulset.yaml
}

deploy_vault() {
    echo "Configuring Vault..."
    kubectl apply -f ./vault/services/vault.yaml
    kubectl create -n $namespace secret generic vault \
        --from-file=./vault/ca/ca.pem \
        --from-file=vault.pem=./vault/ca/vault-combined.pem \
        --from-file=./vault/ca/vault-key.pem
    kubectl apply -f ./vault/configmap.yaml
    kubectl apply -f ./vault/statefulset.yaml
}

namespace=kube-vault
case $1 in
    consul)
        deploy_consul
        ;;
    vault)
        deploy_vault
        ;;
    all)
        deploy_consul
        deploy_vault
        ;;
    *)
        echo "
usage: vault-up [consul | vault | all]
"
		;;
esac
