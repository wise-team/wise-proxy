#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

set -a # automatically export all variables
source .env
set +a

if [ -z ${WISE_ENVIRONMENT_TYPE} ]; then
    echo "WISE_ENVIRONMENT_TYPE env is not set"
    exit 1
fi

if [ -z ${CERTBOT_EMAIL} ]; then
    echo "CERTBOT_EMAIL env is not set"
    exit 1
fi

if [ -z ${CERTBOT_PATH} ]; then
    echo "CERTBOT_PATH env is not set"
    exit 1
fi

if [ -z ${CERT_DOMAINS} ]; then
    echo "CERT_DOMAINS env is not set"
    exit 1
fi


export DOMAINS_OPTS="-d ${CERT_DOMAINS// / -d }"

export CERTBOT_WEBROOT_PATH="${CERTBOT_PATH}/webroot"
export LETSENCRYPT_ETC_DIR="${CERTBOT_PATH}/letsencrypt_etc"
export LETSENCRYPT_LIB_DIR="${CERTBOT_PATH}/letsencrypt_lib"


export IMAGE="nginx"
#§ 'export CONTAINER_NAME="' + data.config.proxy.docker.container + '"'
export CONTAINER_NAME="wise-proxy"

export CACHE_SIZE="256m"
