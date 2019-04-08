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

#Release Jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/release/release-create/integreatly-release-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/release/release-delete/integreatly-release-delete.yaml

#Repo jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/repos/repos-delete-branches-and-tags/repos-delete-branches-and-tags.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/repos/repos-delete-docker-image-tags/repos-delete-docker-image-tags.yaml

#Delorean Jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/misc/github-events/github-events.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/3scale/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/3scale/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/amq-online/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/amq-online/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/backup-container/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/backup-container/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/codeready/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/codeready/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse-online/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse-online/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/gitea/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/gitea/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/middleware-monitoring/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/middleware-monitoring/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/msbroker/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/msbroker/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/rhsso/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/rhsso/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/webapp/next/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/webapp/next/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/suites/integreatly/next/branch.yaml

#OpenShift Cluster Jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/create/openshift-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/deprovision/openshift-cluster-deprovision.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-install.yaml

#Delorean Folders
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/delorean/folders.yaml

#Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/after-first-login-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/alerts-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/amq-online-address-creation-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/browser-based-single-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/browser-based-testsuite-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/customer-admin-permissions-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/fuse-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/installation-smoke-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-uninstall.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/poc-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/poc-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/poc-uninstall.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/psi-clean-uninstall.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/recreate-pipelines.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/sso-user-create.yaml

#Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/repos/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/release/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/delorean/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/openshift/
