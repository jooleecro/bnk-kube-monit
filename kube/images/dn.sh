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

for idx in ${!IMAGE_LIST[*]}
do
    cur_image=${IMAGE_LIST[${idx}]}
    info "pull image ${cur_image}"
    exe docker pull ${cur_image}
done

mkdir -p ${NAME}
exe docker save ${IMAGE_LIST[@]} -o "./${NAME}/${NAME}.tar"
exe gzip "./${NAME}/${NAME}.tar"