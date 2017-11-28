# Enable Vault Kubernetes Auth Plugin

1. Deploy `0.9.0` of `vault` server
2. Install/upgrade to latest cli versino of vault `brew install vault` OR `brew upgrade vault`
3. Create service account named `vault-auth` by running `kubectrl create -f ./vault-service-account.yaml` 
4. If you are using RBAC (ClusterRoleBinding) run `kubectrl create -f ./rbac.yaml`
5. Update `vault-kubernetes-config.sh` `kubernetes_host` with your k8s url
6. Update `vault-kubernetes-config.sh` `kubernetes_ca_cert` with a path to your k8s ca-certificate

>  Note: You can get the `ca_cert` from the `vault-auth-token-xxxx` secret in the `default` namespace

7. Run `sh vault-kubernetes-config.sh`
8. Run `sh vault-kubernetes-role.sh`
9. Attempt to login `vault write auth/kubernetes/login role=vault jwt="..."` 

> Note: You can get the `jwt` from` vault-auth-token-xxxx` secret in the `default` namespace
