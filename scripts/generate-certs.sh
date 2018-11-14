#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh


docker run -it --rm --name certbot \
    -v "${LETSENCRYPT_ETC_DIR}:/etc/letsencrypt" \
    -v "${LETSENCRYPT_LIB_DIR}:/var/lib/letsencrypt" \
    -p 80:80 \
    certbot/certbot certonly \
    --email ${CERTBOT_EMAIL} \
    --agree-tos \
    --standalone --preferred-challenges http \
    ${DOMAINS_OPTS}

