#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"


export DOLLAR="\$"
for f in $(find /conf_templates -regex '.*\.conf'); do
    dest="${f//conf_templates/conf}"
    mkdir -p $(dirname ${dest})
    envsubst < $f > "$dest";
    
    echo ""
    echo "=== $dest ==="
    cat "$dest"
done

nginx -c /conf/nginx.conf -g "daemon off;"