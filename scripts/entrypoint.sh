#!/bin/bash
#
# Will write kubeconfig to a file and then execute helm commands.

set -e
set -x


case $INPUT_PROVIDER in
  "gcp")
    /scripts/gcp.sh
    ;;
  "aws")
    /scripts/aws.sh
    ;;
  *)
    echo "Unknown provider: $INPUT_PROVIDER"
    ;;
esac


/scripts/helm.sh
