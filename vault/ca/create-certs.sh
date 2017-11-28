#!/bin/bash

NAMESPACE="kube-vault"

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
cfssl gencert \
  -ca=ca.pem \
  -ca-key=ca-key.pem \
  -config=ca-config.json \
  -hostname="consul,consul.${NAMESPACE}.svc.cluster.local,server.dc1.consul,server.dc1.cluster.local,vault,vault.${NAMESPACE}.svc.cluster.local,localhost,vault.dc1.cluster.local,vault.service.consul,127.0.0.1,vault.hosting.gigster.com,vault.gde.gigsternetwork.com,vault.aws.gigsternetwork.com,vault.gigsternetwork.com" \
  -profile=default vault-csr.json | cfssljson -bare vault
cat vault.pem ca.pem > vault-combined.pem
