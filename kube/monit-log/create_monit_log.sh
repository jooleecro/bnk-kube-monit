#!/usr/bin/env bash

set -e
set -o pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd ${SCRIPT_DIR}
source ./config.env
source ../common/function.env
source ../common/logger.env


info "create monit log"
exe kubectl apply -f - <<< "${YML_NAME_SPACE}"

exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_PV}"
exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_PVC}"
exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_SERVICE}"
exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_STATEFULLSET}"
exe kubectl apply -f - <<< "${YML_KIBANA_SERVICE}"
exe kubectl apply -f - <<< "${YML_KIBANA_DEPLOYMENT}"