#!/usr/bin/env bash

set -e
set -o pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd ${SCRIPT_DIR}
source ./config.env
source ../common/function.env
source ../common/logger.env


info "create monit log"
exe kubectl create -f - <<< "${YML_CLUSTER_ROLE}"

exe kubectl create -f - <<< "${YML_CONFIG_MAP}"

exe kubectl create -f - <<< "${YML_DEPLOYMENT_PROMETHEUS}"
exe kubectl create -f - <<< "${YML_SERVICE_PROMETHEUS}"
#exe kubectl create -f - <<< "${YML_DEPLOYMENT_GRAFANA}"

exe kubectl get all -n ${NAME_SPACE}
exe kubectl get all -n kube-system