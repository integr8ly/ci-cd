#!/bin/sh

# Exit on error
set -e
# Verbose output of cmds
# set -x

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"

alias jenkins-jobs="docker run --env PYTHONHTTPSVERIFY=0 --privileged --rm -it -v $SCRIPTS_DIR/..:$SCRIPTS_DIR/.. docker-registry.engineering.redhat.com/mobile/jenkins-job-builder:latest jenkins-jobs"

generate_inline_script_job() {
  $SCRIPTS_DIR/generate_inline_script_pipeline_job -j $1 -o $SCRIPTS_DIR/../jobs/generated
}

generate_inline_script_job $SCRIPTS_DIR/../jobs/release/release-create/integreatly-release-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release/release-delete/integreatly-release-delete.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/repos/repos-delete-branches-and-tags/repos-delete-branches-and-tags.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/repos/repos-delete-docker-image-tags/repos-delete-docker-image-tags.yaml

#Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

#Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/repos/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/release/
