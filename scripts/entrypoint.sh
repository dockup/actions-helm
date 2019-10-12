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
     # Exporting here so that `helm.sh` can work!
     export AWS_ACCESS_KEY_ID=$INPUT_AWS_ACCESS_KEY_ID
     export AWS_SECRET_ACCESS_KEY=$INPUT_AWS_SECRET_ACCESS_KEY
    /scripts/aws.sh
    ;;
  *)
    echo "Unknown provider: $INPUT_PROVIDER"
    ;;
esac


/scripts/helm.sh
