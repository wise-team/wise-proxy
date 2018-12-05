#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ./config.sh

docker stop "${CONTAINER_NAME}" > /dev/null || echo "No need to stop previous container."
docker rm "${CONTAINER_NAME}"  > /dev/null || echo "No need to rm previous container"

docker run \
  -it \
  --name "${CONTAINER_NAME}" \
  --restart always \
  --network="host" \
  --memory-swappiness=0 \
  --tmpfs /var/cache/nginx:rw,size=${CACHE_SIZE},uid=101,mode=1777 \
  --env-file "${PWD}/.env" \
  -u root \
  -v "${PWD}/conf_templates:/conf_templates:ro" \
  -v "${PWD}/entry.sh:/entry.sh:ro" \
  "${IMAGE}" /entry.sh

# -d
#-v "${CERTBOT_WEBROOT_PATH}:/cert_webroot" \
#  -v "${LETSENCRYPT_ETC_DIR}:/cert/:ro" \