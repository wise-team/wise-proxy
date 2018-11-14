#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "${WISE_ENVIRONMENT_TYPE}" = "production" ]; then
    #§ 'export DOMAINS_OPTS="-d ' + data.config.proxy.certs.domains.production.join(" -d ") + '"'
    export DOMAINS_OPTS="-d wise.vote -d sql.wise.vote -d hub.wise.vote -d test.wise.vote"
elif [ "${WISE_ENVIRONMENT_TYPE}" = "staging" ]; then
    #§ 'export DOMAINS_OPTS="-d ' + data.config.proxy.certs.domains.staging.join(" -d ") + '"'
    export DOMAINS_OPTS="-d dev.wise.jblew.pl -d sql.dev.wise.jblew.pl -d hub.dev.wise.jblew.pl -d test.dev.wise.jblew.pl"
else 
    echo "Given WISE_ENVIRONMENT_TYPE not present or not supported"
    exit 1
fi

#§ 'export LETSENCRYPT_ETC_DIR="' + data.config.proxy.certs.letsencryptEtcDir + '"'
export LETSENCRYPT_ETC_DIR="/opt/wise/certs/letsencrypt_etc"

#§ 'export LETSENCRYPT_LIB_DIR="' + data.config.proxy.certs.letsencryptLibDir + '"'
export LETSENCRYPT_LIB_DIR="/opt/wise/certs/letsencrypt_lib"

export IMAGE="nginx"
#§ 'export CONTAINER_NAME="' + data.config.proxy.docker.container + '"'
CONTAINER_NAME="wise-proxy"

export CACHE_SIZE="256m"


export SITES_VOLUMES=""
export HTML_VOLUMES=""

export SITES_VOLUMES="${SITES_VOLUMES} -v ${PWD}/sites/default.conf:/sites/default.conf:ro "
export HTML_VOLUMES="${HTML_VOLUMES} -v ${PWD}/html_main:/html/main:ro "