# shellcheck shell=bash
# vim: ft=bash

use_vault () {
    # In CI environment, require VAULT_TOKEN to be set externally
    if test -n "${CI}"; then
        strict_env env_vars_required VAULT_ADDR VAULT_TOKEN
        return 0
    fi

    strict_env env_vars_required VAULT_ADDR

    if ! has vault; then
        log_error "HashiCorp Vault is not installed"
        return 1
    fi

    #VAULT_TOKEN="$(vault read -field=id /auth/token/lookup-self)"
    #if [ "${?}" -gt "0" ]; then
    if ! VAULT_TOKEN="$(vault read -field=id /auth/token/lookup-self)"; then
    	log_warn "Seems like 'vault token lookup' failed. Try logging in into Vault again with 'vault login -method=oidc'"
        return 1
    fi

    export VAULT_TOKEN
}
