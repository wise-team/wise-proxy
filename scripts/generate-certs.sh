#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh


sudo docker run -it --rm --name certbot \
    -v "${LETSENCRYPT_ETC_DIR}:/etc/letsencrypt" \
    -v "${LETSENCRYPT_LIB_DIR}:/var/lib/letsencrypt" \
    certbot/certbot certonly \
    --standalone --preferred-challenges http \
    --email ${CERTBOT_EMAIL} \
    ${DOMAINS_OPTS}

