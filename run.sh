#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ./config.sh

docker stop "${CONTAINER_NAME}" || echo "No need to stop previous container."
docker rm "${CONTAINER_NAME}" || echo "No need to rm previous container"

docker run \
  --name "${CONTAINER_NAME}" \
  --restart always \
  --network="host" \
  --memory-swappiness=0 \
  --tmpfs /var/cache/nginx:rw,size=${CACHE_SIZE},uid=101,mode=1777 \
  --tmpfs /var/run:rw,size=20k,uid=101,mode=1777 \
  -u root \
  -v "${CERTBOT_WEBROOT_PATH}:/cert_webroot" \
  -v "${PWD}/nginx.${WISE_ENVIRONMENT_TYPE}.conf:/etc/nginx/nginx.conf:ro" \
  -v "${PWD}/conf:/conf:ro" \
  -v "${LETSENCRYPT_ETC_DIR}:/cert/:ro" \
  -d \
  "${IMAGE}"
