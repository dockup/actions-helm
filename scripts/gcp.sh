#!/bin/bash
#
# Uses gcloud to obtain kubernetes credentials for service account

set -e

echo $INPUT_GCP_CREDENTIALS | base64 -d > sa.json

export PATH=/google-cloud-sdk/bin:$PATH

gcp_project=$(cat sa.json | jq -r .project_id)
gcloud auth activate-service-account --key-file=sa.json
gcloud config set project $gcp_project
gcloud container clusters get-credentials $INPUT_CLUSTER_NAME \
       --region=$INPUT_CLUSTER_REGION
