#!/usr/bin/env bash

set -e
set -o pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd ${SCRIPT_DIR}

source ./config.env
source ../common/function.env
source ../common/logger.env


config_file=${1}
if [ ! -e ${config_file} ]
then
    echo "usage) create_monit_log.sh <config env file>" > 2&
    exit 1
fi

info "delete monit log"

echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_KIBANA_DEPLOYMENT}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_KIBANA_SERVICE}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_ELASTICSEARCH_STATEFULLSET}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_ELASTICSEARCH_SERVICE}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_ELASTICSEARCH_PVC}" || true)
echo $(exe kubectl delete --grace-period=0 --force -f - <<< "${YML_ELASTICSEARCH_PV}" || true)