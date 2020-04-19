#!/bin/bash

set -Eeuox pipefail

curl -sSfL \
  "https://raw.githubusercontent.com/${CIRCLE_PROJECT_USERNAME}/${CIRCLE_PROJECT_REPONAME}/master/install.sh" \
  | sh -s "${CIRCLE_TAG}"

"./bin/${CIRCLE_PROJECT_REPONAME}" help
"./bin/${CIRCLE_PROJECT_REPONAME}" version | grep -q "${CIRCLE_TAG}" || exit 1

hub=${DOCKER_HUB_NAME:-oryd}
docker run --rm \
  "${hub}/${CIRCLE_PROJECT_REPONAME}:${CIRCLE_TAG}" help
docker run --rm \
  "${hub}/${CIRCLE_PROJECT_REPONAME}:${CIRCLE_TAG}" version | grep -q "${CIRCLE_TAG}" || exit 1
