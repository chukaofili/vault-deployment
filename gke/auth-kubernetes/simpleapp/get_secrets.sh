#!/bin/bash
    
JSON_WEB_TOKEN=`cat /var/run/secrets/kubernetes.io/serviceaccount/token`
VAULT_TOKEN=`curl -k https://${VAULT_SERVICE_HOST}:${VAULT_SERVICE_PORT}/v1/auth/kubernetes/login -d '{ "jwt": "'"${JSON_WEB_TOKEN}"'", "role": "'"${VAULT_SERVICE_ACCOUNT_ROLE}"'" }'  | jq -r '.auth.client_token'`
envsubst < /env_config/config.tmp.hcl > /tmp/config.hcl
envconsul -config="/tmp/config.hcl" -vault-token=${VAULT_TOKEN} -once printenv > /tmp/secrets

if [ ${SECRET_FOLDER} ]
then
    cp /tmp/secrets /${SECRET_FOLDER}/secrets
fi