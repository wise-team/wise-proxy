#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh


docker run --rm --name certbot \
    -v "${LETSENCRYPT_ETC_DIR}:/etc/letsencrypt" \
    -v "${LETSENCRYPT_LIB_DIR}:/var/lib/letsencrypt" \
    -p 80:80 \
    certbot/certbot certonly \
    --email ${CERTBOT_EMAIL} \
    --agree-tos \
    --non-interactive \
    --standalone --preferred-challenges http \
    ${DOMAINS_OPTS}

chmod -R 755 "${LETSENCRYPT_ETC_DIR}"