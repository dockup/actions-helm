#!/bin/bash
#
# Will write kubeconfig to a file and then execute helm commands.

set -e

echo $INPUT_GCP_CREDENTIALS | base64 -d > sa.json

export PATH=/google-cloud-sdk/bin:$PATH

gcp_project=$(cat sa.json | jq -r .project_id)
gcloud auth activate-service-account --key-file=sa.json
gcloud config set project $gcp_project
gcloud container clusters get-credentials $INPUT_CLUSTER_NAME \
       --region=$INPUT_CLUSTER_REGION


helm init --client-only
helm repo update
overrides=$(echo $INPUT_SET | xargs -n 1 | tr '\n' ',')
helm upgrade --set $overrides $INPUT_NAME $INPUT_CHART_NAME
