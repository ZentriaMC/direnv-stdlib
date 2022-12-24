# use\_vault

Sets up `VAULT_TOKEN` in current environment and ensures it's valid. Opinionated for usage with OIDC method.

## Usage

```shell
use vault
```

## Notes

HashiCorp Vault binary operates using `~/.vault-token`, so this function might be inconvenient to use with different Vault instances/namespaces.

If `CI` environment variable is set, then token validity check will be skipped (assumes token is always valid in CI).
