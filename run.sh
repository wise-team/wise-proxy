#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ./config.sh

IMAGE="nginx"
#§ 'CONTAINER_NAME="' + data.config.proxy.docker.container + '"'
CONTAINER_NAME="wise-proxy"
CACHE_SIZE="256m"

docker run \
  --name "${CONTAINER_NAME}" \
  --restart always \
  --network="host" \
  --memory-swappiness=0 \
  --read-only \
  --tmpfs /var/cache/nginx:rw,noexec,nosuid,size=${CACHE_SIZE} \
  --tmpfs /var/run:rw,noexec,nosuid,size=20k \
  -u nginx \
  -v "${PWD}/nginx.conf:/etc/nginx/nginx.conf:ro" \
  -v "${CERTBOT_WEBROOT_PATH}:/cert/webroot:ro" \
  -v "${LETSENCRYPT_ETC_DIR}:/cert/letsencrypt_etc:ro" \
  -v "${DIR}/html_main:/html/main:ro" \
  -d \
  "${IMAGE}"
