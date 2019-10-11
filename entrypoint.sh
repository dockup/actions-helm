#!/bin/bash
#
# Will write kubeconfig to a file and then execute helm commands.

set -x
set -e


helm "$@"
