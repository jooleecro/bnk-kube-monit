#!/bin/bash
set -e
set -o pipefail
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
cd ${SCRIPT_DIR}


./dn.sh elastic.env
./dn.sh rancher-logging.env
./dn.sh rancher-monitoring.env

./split.sh elastic.env
./split.sh rancher-logging.env
./split.sh rancher-monitoring.env