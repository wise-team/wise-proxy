#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


#§ 'CERTBOT_WEBROOT_PATH="' + data.config.proxy.certs.webroot + '"'
CERTBOT_WEBROOT_PATH="/opt/wise/certs/webroot"

#§ 'LETSENCRYPT_ETC_DIR="' + data.config.proxy.certs.letsencryptEtcDir + '"'
LETSENCRYPT_ETC_DIR="/opt/wise/certs/letsencrypt_etc"

#§ 'LETSENCRYPT_LIB_DIR="' + data.config.proxy.certs.letsencryptLibDir + '"'
LETSENCRYPT_LIB_DIR="/opt/wise/certs/letsencrypt_lib"
