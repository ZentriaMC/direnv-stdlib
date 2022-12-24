# shellcheck shell=bash
# vim: ft=bash

log_warn () {
    if [[ -n $DIRENV_LOG_FORMAT ]]; then
        local msg=$*
        local color_normal="\e[m"
        local color_warn="\033[0;33m"
        # shellcheck disable=SC2059,SC1117
        printf "${color_warn}${DIRENV_LOG_FORMAT}${color_normal}\n" "$msg" >&2
    fi
}
