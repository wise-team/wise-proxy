#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ./config.sh

docker stop "${CONTAINER_NAME}" > /dev/null || echo "No need to stop previous container."
docker rm "${CONTAINER_NAME}"  > /dev/null || echo "No need to rm previous container"

docker run \
  --name "${CONTAINER_NAME}" \
  --restart always \
  --network="host" \
  --memory-swappiness=0 \
  --tmpfs /var/cache/nginx:rw,size=${CACHE_SIZE},uid=101,mode=1777 \
  -v "${CERTBOT_WEBROOT_PATH}:/cert_webroot" \
  -v "${LETSENCRYPT_ETC_DIR}:/cert/:ro" \
  --env-file "${PWD}/.env" \
  -u root \
  -v "${PWD}/conf_templates:/conf_templates:ro" \
  -v "${PWD}/entry.sh:/entry.sh:ro" \
  -v "${PWD}/html:/html:ro" \
  -d \
  "${IMAGE}" /entry.sh


echo "Wait for container and check its health"
sleep 4

docker logs "${CONTAINER_NAME}"
CONTAINER_INFO=$(docker container inspect ${CONTAINER_NAME})
CONTAINER_STATE=$(echo $CONTAINER_INFO | jq ".[0].State.Status")
echo "State: ${CONTAINER_STATE}"


if [[ "${CONTAINER_STATE}" == "running" ]]; then
  echo "Container is running properly"
else
  echo "Failed to start nginx (state=${CONTAINER_STATE}). Removing container and exitting"
  docker stop "${CONTAINER_NAME}" || echo "Ok"
  docker rm "${CONTAINER_NAME}"
  exit 1
fi
