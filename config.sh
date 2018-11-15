#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ "${WISE_ENVIRONMENT_TYPE}" = "production" ]; then
    #§ 'export DOMAINS_OPTS="-d ' + data.config.proxy.certs.domains.production.join(" -d ") + '"'
    export DOMAINS_OPTS="-d wise.vote -d sql.wise.vote -d hub.wise.vote -d test.wise.vote"
    #§ 'export CERTBOT_EMAIL="' + data.config.environments.production.certbot.email + '"'
    export CERTBOT_EMAIL="noisy.pl@gmail.com"
elif [ "${WISE_ENVIRONMENT_TYPE}" = "staging" ]; then
    #§ 'export DOMAINS_OPTS="-d ' + data.config.proxy.certs.domains.staging.join(" -d ") + '"'
    export DOMAINS_OPTS="-d dev.wise.jblew.pl -d sql.dev.wise.jblew.pl -d hub.dev.wise.jblew.pl -d test.dev.wise.jblew.pl"
    #§ 'export CERTBOT_EMAIL="' + data.config.environments.staging.certbot.email + '"'
    export CERTBOT_EMAIL="jedrzejblew@gmail.com"
else 
    echo "Given WISE_ENVIRONMENT_TYPE not present or not supported"
    exit 1
fi


#§ 'CERTBOT_WEBROOT_PATH="' + data.config.proxy.certs.webroot + '"'
CERTBOT_WEBROOT_PATH="/opt/wise/certs/webroot"

#§ 'export LETSENCRYPT_ETC_DIR="' + data.config.proxy.certs.letsencryptEtcDir + '"'
export LETSENCRYPT_ETC_DIR="/opt/wise/certs/letsencrypt_etc"

#§ 'export LETSENCRYPT_LIB_DIR="' + data.config.proxy.certs.letsencryptLibDir + '"'
export LETSENCRYPT_LIB_DIR="/opt/wise/certs/letsencrypt_lib"



export IMAGE="nginx"
#§ 'export CONTAINER_NAME="' + data.config.proxy.docker.container + '"'
export CONTAINER_NAME="wise-proxy"

export CACHE_SIZE="256m"
