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

source ${config_file}



info "create monit log"
exe kubectl apply -f - <<< "${YML_NAME_SPACE}"

exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_PV}"
exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_PVC}"
exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_SERVICE}"
exe kubectl apply -f - <<< "${YML_ELASTICSEARCH_STATEFULLSET}"
exe kubectl apply -f - <<< "${YML_KIBANA_SERVICE}"
exe kubectl apply -f - <<< "${YML_KIBANA_DEPLOYMENT}"