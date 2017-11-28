#!/bin/bash

vault write auth/kubernetes/config \
    kubernetes_host=https://35.196.42.113 \
    kubernetes_ca_cert=@ca_cert.pem