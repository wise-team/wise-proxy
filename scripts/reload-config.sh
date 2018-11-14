#!/usr/bin/env bash
set -e # fail on first error
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "${DIR}"

source ../config.sh

docker container exec "${CONTAINER_NAME}" nginx -t
docker container exec "${CONTAINER_NAME}" nginx -s reload