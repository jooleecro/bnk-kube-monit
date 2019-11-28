#!/bin/bash -v


REGISTRY=$1

RANCHER_IMAGE_LIST=$(cat << EOF
busybox:latest
elastic/kibana:6.4.0
elastic/elasticsearch:6.4.0
rancher/coreos-prometheus-operator:v0.29.0
rancher/coreos-prometheus-config-reloader:v0.29.0
rancher/coreos-configmap-reload:v0.0.1
rancher/prom-node-exporter:v0.17.0
rancher/coreos-kube-state-metrics:v1.5.0
rancher/prom-alertmanager:v0.17.0
rancher/grafana-grafana:5.4.3
rancher/prometheus-auth:v0.2.0
rancher/nginx:1.15.8-alpine
rancher/prom-prometheus:v2.7.1
rancher/prometheus-auth:v0.2.0
rancher/nginx:1.15.8-alpine
rancher/log-aggregator:v0.1.5
rancher/fluentd:v0.1.13
rancher/jimmidyson-configmap-reload:v0.2.2
EOF
)
cat x* > monit.tar.gz


docker load monit.tar.gz


for i in ${RANCHER_IMAGE_LIST}; do
    docker tag ${i} ${REGISTRY}/${i}
    docker push ${REGISTRY}/${i}
    docker rmi ${i}
    docker rmi ${i} ${REGISTRY}/${i}
done
