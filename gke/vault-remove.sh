#!/bin/bash

delete_consul() {
    echo "De-provisioning Consul.."
    kubectl delete -f ./consul/configmap.yaml
    kubectl delete -f ./consul/statefulset.yaml
    kubectl delete -n $namespace pvc consul-data-consul-0 consul-data-consul-1 consul-data-consul-2
    kubectl delete -n $namespace secret consul
    kubectl delete -f ./consul/service.yaml
}

delete_vault() {
    echo "De-provisioning Vault.."
    kubectl delete -f ./vault/configmap.yaml
    kubectl delete -f ./vault/statefulset.yaml
    kubectl delete -n $namespace pvc consul-data-vault-0 vault-log-data-vault-0
    kubectl delete -n $namespace secret vault
    kubectl delete -f ./vault/service.yaml
    # kubectl delete -f ./vault/ingress.yaml
}

namespace=vault
case $1 in
    consul)
        delete_consul
        ;;
    vault)
        delete_vault
        ;;
    all)
        delete_vault
        delete_consul
        ;;
    *)
        echo "
usage: vault-down [consul | vault | all]
"
		;;
esac