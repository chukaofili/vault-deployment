# Prerequisites

Install the following client tools and ensure they are in your path:

* [vault](https://www.vaultproject.io/downloads.html) 0.8.2

## Install Client Tools

```
$ brew install vault
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

## Authentication Instructions

**Authenticating to Vault**

To authenticate with gigster's vault deployment, you'll need a Github Personal Access Token. Access your Personal Access Tokens in GitHub at https://github.com/settings/tokens. Generate a new Token that has the scope **read:org**. Save the generated token. This is what you will provide to vault.

```
$ vault auth -method=github token=<github personal access token>
```
```
Successfully authenticated! You are now logged in.
The token below is already saved in the session. You do not
need to "vault auth" again with the token.
token: xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
token_duration: 2764800
token_policies: [default gigter-dev]
```