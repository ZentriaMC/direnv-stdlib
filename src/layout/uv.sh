# shellcheck shell=bash
# vim: ft=bash

layout_uv () {
    if ! has uv; then
        log_error "uv is not installed"
        return 1
    fi

    PYPROJECT_TOML="${PYPROJECT_TOML:-pyproject.toml}"
    if [[ ! -f "$PYPROJECT_TOML" ]]; then
        log_error "No pyproject.toml found"
        return 1
    fi

    VIRTUAL_ENV="$(realpath .)/.venv"
    if [[ ! -d $VIRTUAL_ENV ]]; then
        log_status "Executing \`uv sync\` to set up initial environment"
        uv sync
    fi

    PATH_add "$VIRTUAL_ENV/bin"
    export VIRTUAL_ENV
}
