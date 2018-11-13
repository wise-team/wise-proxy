#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh

#§ 'WEBROOT_PATH="' + data.config.proxy.certs.webroot + '"'
WEBROOT_PATH="/opt/wise/certs/webroot"

sudo docker run -it --rm --name certbot \
    -v "${LETSENCRYPT_ETC_DIR}:/etc/letsencrypt" \
    -v "${LETSENCRYPT_LIB_DIR}:/var/lib/letsencrypt" \
    certbot/certbot renew \
    --webroot --webroot-path="${CERTBOT_WEBROOT_PATH}" \

