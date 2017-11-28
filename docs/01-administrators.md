# Prerequisites

Install the following client tools and ensure they are in your path:

* [cfssl](https://github.com/cloudflare/cfssl) 1.2.0
* [cfssljson](https://github.com/cloudflare/cfssl) 1.2.0
* [consul](https://www.consul.io/downloads.html) 0.9.3
* [vault](https://www.vaultproject.io/downloads.html) 0.8.2
* [kubectl](https://cloud.google.com/sdk/docs/components) 1.7.3
* [jq](https://stedolan.github.io/jq/download/) 1.5
* [keybase.io](https://keybase.io/)

## Install Client Tools

```
$ brew install cfssl
$ brew install consul
$ brew install vault
$ brew install kubectl
$ brew install jq
```

## Deployment

Please note: Always deploy consul first & make sure it is running before deploying vault.


**Changing Hostnames**
Create new ssl certs to be shared by consul and vault

```
cd vault/ca/
sh create-certs.sh
```

**Deploying on k8s**

```
$ cd /path-to-your-repo/
$ sh vault-up.sh consul
$ sh vault-up.sh vault
```

To see status of deployment

```
$ kubectl get -n kube-vault po,svc,cm,secrets,statefulsets,pvc -o wide
```

**Removing from k8s**

```
$ sh vault-down.sh all
```

## Connection Instructions

**Connecting to Vault**

To access the gigster vault deployment, change directory to the vault folder within the repo & source vault.env

```
$ cd /path-to-your-repo/vault/
$ source vault.env
```

Check to see if you can see the vault status message, if you see this information about the vault server you are good to go, else contact the maintainer/developer on slack for help. :)

```
$ vault status
```
```
Sealed: false
Key Shares: 2
Key Threshold: 2
Unseal Progress: 0
Unseal Nonce:
Version: 0.8.2
Cluster Name: vault-cluster-XXXXXXXX
Cluster ID: XXXXXXXX-XXXX-XXX-XXX-XXXXXXXXXXXX

High-Availability Enabled: true
	Mode: active
	Leader Cluster Address: https://XX.X.X.X:8201
```

**Sealing / Unsealing Instructions**

Before you can use vault, it needs to be initiatized the first time & then unsealed.

* Documentation on how to initialize vault lives [here](https://www.vaultproject.io/intro/getting-started/deploy.html#initializing-the-vault) (Please note: The gigster vault deployment has already been initialized, this is only needed if it is a fresh deployment).

* To unseal/seal vault, you'll need the unseal tokens used to initialize vault. (Please note: this is not the root token). Documentation on how to seal/unseal vault lives [here](https://www.vaultproject.io/intro/getting-started/deploy.html#seal-unseal)

> Please note: if your token was encrypted using your keybase pgp public key, you'll need to decypt it first using keybase.

> Mac Users **(please note the capital -D option)**:
> ```
> $ echo "YOUR-VAULT-ENCRYPTED-PGP-TOKEN" | base64 -D | keybase pgp decrypt
> ```

> Others:
> ```
> $ echo "YOUR-VAULT-ENCRYPTED-PGP-TOKEN" | base64 -d | keybase pgp decrypt
> ```

```
$ vault unseal
```
```
Key (will be hidden):
Sealed: false
Key Shares: 5
Key Threshold: 3
Unseal Progress: 0
Unseal Nonce:
```

or

```
$ vault seal
```


## Updating Vault teams

vault auth-enable github
vault write auth/github/config organization=gigster-eng
vault write auth/github/map/users/fridiculous value=admin
vault write auth/github/map/users/chukaofili value=admin
vault write auth/github/map/users/pete-j-turnbull value=admin
vault write sys/policy/admin rules=@vault/admin-accounts.hcl
