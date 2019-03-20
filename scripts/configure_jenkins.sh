#!/bin/sh

# Exit on error
set -e
# Verbose output of cmds
# set -x

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"

alias jenkins-jobs="docker run --env PYTHONHTTPSVERIFY=0 --privileged --rm -v $SCRIPTS_DIR/..:$SCRIPTS_DIR/.. docker-registry.engineering.redhat.com/mobile/jenkins-job-builder:latest jenkins-jobs"

generate_inline_script_job() {
  $SCRIPTS_DIR/generate_inline_script_pipeline_job -j $1 -o $SCRIPTS_DIR/../jobs/generated
}

rm -rf $SCRIPTS_DIR/../jobs/generated/*

generate_inline_script_job $SCRIPTS_DIR/../jobs/release/release-create/integreatly-release-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release/release-delete/integreatly-release-delete.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/repos/repos-delete-branches-and-tags/repos-delete-branches-and-tags.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/repos/repos-delete-docker-image-tags/repos-delete-docker-image-tags.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/3scale.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/backup-container.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/codeready.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/fuse.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/fuse-online.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/gitea.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/msbroker.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/middleware-monitoring.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/rhsso.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/webapp.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/discovery/amq-online.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/3scale-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/backup-container-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/codeready-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/fuse-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/fuse-online-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/gitea-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/msbroker-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/middleware-monitoring-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/rhsso-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/webapp-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/branch/amq-online-next.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release-monitoring/github-events/release-monitoring-github-events.yaml

#Folders
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/release-monitoring/release-monitoring-folders.yaml

#Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/after-first-login-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/alerts-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/browser-based-test-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/browser-based-testsuite-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/clean-uninstallation-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/customer-admin-permissions-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/fuse-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/installation-pipeline-qe-pony.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/installation-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/installation-smoke-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-general.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/qe-poc-master-general.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/uninstallation-pipeline-qe-pony.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/uninstallation-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/recreate-pipelines.yaml

#Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/repos/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/release/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/monitoring/
