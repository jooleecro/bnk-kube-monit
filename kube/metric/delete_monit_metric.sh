#!/usr/bin/env bash

set -e
set -o pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd ${SCRIPT_DIR}
source ./config.env
source ../common/function.env
source ../common/logger.env

info "delete monit log"

#exe kubectl delete --grace-period=0 --force -f - <<< "${YML_FLUENTD}"
#echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_DEPLOYMENT_GRAFANA}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_SERVICE_PROMETHEUS}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_DEPLOYMENT_PROMETHEUS}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_CONFIG_MAP}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_CLUSTER_ROLE}" || true)






