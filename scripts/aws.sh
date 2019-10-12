#!/bin/bash
#
# Will use aws authenticator to obtain credentials

set -e


aws eks --region $INPUT_CLUSTER_REGION update-kubeconfig \
    --name $INPUT_CLUSTER_NAME
