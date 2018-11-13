#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh

if [ $WISE_ENVIRONMENT_TYPE = "production" ]; then
    #§ 'WEBROOT_PATH="-d ' + data.config.proxy.certs.domains.production.join(" -d ") + '"'
    WEBROOT_PATH="-d wise.vote -d sql.wise.vote -d hub.wise.vote -d test.wise.vote"
elif [ $WISE_ENVIRONMENT_TYPE = "staging" ]; then
    #§ 'WEBROOT_PATH="-d ' + data.config.proxy.certs.domains.staging.join(" -d ") + '"'
    WEBROOT_PATH="-d dev.wise.jblew.pl -d sql.dev.wise.jblew.pl -d hub.dev.wise.jblew.pl -d test.dev.wise.jblew.pl"
else 
    echo "Given WISE_ENVIRONMENT_TYPE not present or not supported"
    exit 1
fi

sudo docker run -it --rm --name certbot \
    -v "${LETSENCRYPT_ETC_DIR}:/etc/letsencrypt" \
    -v "${LETSENCRYPT_LIB_DIR}:/var/lib/letsencrypt" \
    certbot/certbot certonly \
    --webroot --webroot-path="${CERTBOT_WEBROOT_PATH}" \
    ${DOMAINS_OPTS}

