#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh


docker run -it --rm --name certbot \
    -v "${LETSENCRYPT_ETC_DIR}:/etc/letsencrypt" \
    -v "${LETSENCRYPT_LIB_DIR}:/var/lib/letsencrypt" \
    -v "${CERTBOT_WEBROOT_PATH}:/webroot:rw" \
    certbot/certbot renew \
    --email ${CERTBOT_EMAIL} \
    --agree-tos \
    --webroot --webroot-path="/webroot"

chmod -R 755 "${LETSENCRYPT_ETC_DIR}"