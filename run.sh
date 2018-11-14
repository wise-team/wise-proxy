#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ./config.sh

docker run \
  --name "${CONTAINER_NAME}" \
  --restart always \
  --network="host" \
  --memory-swappiness=0 \
  --tmpfs /var/cache/nginx:rw,noexec,nosuid,size=${CACHE_SIZE},mode=1777 \
  --tmpfs /var/run:rw,noexec,nosuid,size=20k,mode=1777 \
  -u nginx \
  -v "${CERTBOT_WEBROOT_PATH}:/cert_webroot" \
  -v "${PWD}/nginx.${WISE_ENVIRONMENT_TYPE}.conf:/etc/nginx/nginx.conf:ro" \
  -v "${PWD}/conf:/conf:ro" \
  -v "${LETSENCRYPT_ETC_DIR}:/cert/:ro" \
  ${SITES_VOLUMES} ${HTML_VOLUMES} \
  -d \
  "${IMAGE}"
