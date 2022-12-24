#!/usr/bin/env bash
set -euo pipefail

: "${URL_PREFIX}"

root="$(git rev-parse --show-toplevel)"
commit="$(git rev-parse HEAD)"
describe="$(git describe --dirty --always --abbrev)"

sri () {
    local file="${1}"
    local _hash

    _hash="$(openssl dgst -sha256 -binary "${file}" | openssl base64 -A)"
    echo "sha256-${_hash}"
}

fmt_script () {
    local path="${1}"
    local srihash="${2}"
    local doc="${3}"


    cat <<EOF

## $( if [ -n "${doc}" ]; then echo -n "[${path}](${doc})"; else echo -n "${path} (no doc)"; fi )

\`\`\`
source_url '${URL_PREFIX}/${path}' '${srihash}'
\`\`\`

EOF
}

[ -d "${root}/dist" ] && rm -rf "${root}/dist"
mkdir -p "${root}/dist"

cat >> "${root}/dist/index.md" <<EOF
# [Zentria direnv-stdlib](https://github.com/ZentriaMC/direnv-stdlib)

Built from commit [${describe}](https://github.com/ZentriaMC/direnv-stdlib/commit/${commit})
EOF

pushd "${root}/src" > /dev/null
find . -type f -name "*.sh" -printf '%P\n' | while read -r script; do
    docfile="${script}.md"
    name="$(basename -- "${script}")"
    srihash="$(sri "${script}")"

    docname=""
    if [ -f "${docfile}" ]; then
        docname="${docfile/\.*/.html}"
        output="${root}/dist/${docname}"
        mkdir -p "$(dirname -- "${output}")"

        lowdown -t html -o "${output}" "${docfile}"

        echo "${script} => ${srihash} (${docfile})"
    else
        echo "${script} => ${srihash} (no doc)"
    fi

    cp "${script}" "${root}/dist/${script}"
    fmt_script "${script}" "${srihash}" "${docname}" >> "${root}/dist/index.md"
done
popd > /dev/null

lowdown -t html -o "${root}/dist/index.html" "${root}/dist/index.md"
rm "${root}/dist/index.md"
