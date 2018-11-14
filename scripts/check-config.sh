#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh

docker run \
  -u nginx \
  -v "${PWD}/nginx.${WISE_ENVIRONMENT_TYPE}.conf:/etc/nginx/nginx.conf:ro" \
  -v "${PWD}/conf:/conf:ro" \
  -v "${LETSENCRYPT_ETC_DIR}:/cert/:ro" \
  ${SITES_VOLUMES} ${HTML_VOLUMES} \
  "${IMAGE}" \
  nginx -t
