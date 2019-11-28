#!/bin/bash
set -e
set -o pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd ${SCRIPT_DIR}

source ./config.env
source ../common/function.env
source ../common/logger.env

config_file=${1}
if [[ ! -e ${config_file} ]]
then
    echo "usage) ${0} <config env file>" >&2
    exit 1
fi

source ${config_file}
cd ./${NAME}
exe cat "x??" > "${NAME}.tar.gz"
exe rm -rf "./x??"
cd ${SCRIPT_DIR}
