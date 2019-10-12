#!/bin/bash
#
# Will write kubeconfig to a file and then execute helm commands.

set -e

helm init --client-only
helm repo update

if [ -n $INPUT_VALUES_FILE ]; then
  echo $INPUT_VALUES_FILE | base64 -d > values.yaml
else
  touch values.yaml
fi
set_overrides=$(echo $INPUT_SET | xargs -n 1 | tr '\n' ',')

helm upgrade --values values.yaml --set $set_overrides \
     $INPUT_NAME $INPUT_CHART_NAME
