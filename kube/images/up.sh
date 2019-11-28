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

exe docker load "./${NAME}/${NAME}.tar.gz"

for idx in ${!IMAGE_LIST[*]}
do
    cur_image=${IMAGE_LIST[${idx}]}
    to_image="/${REGISTRY}/${cur_image}"
    exe docker tag "${cur_image}" "${to_image}"
    exe docker push "${to_image}"
    exe docker rmi "${cur_image}"
#    exe docker rmi "${to_image}"
done