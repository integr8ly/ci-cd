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
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/3scale/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/3scale/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/3scale/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/3scale/rc/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/amq-online/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/amq-online/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/amq-online/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/amq-online/rc/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/backup-container/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/backup-container/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/codeready/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/codeready/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse-online/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse-online/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse-online/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/fuse-online/rc/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/gitea/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/gitea/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/middleware-monitoring/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/middleware-monitoring/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/msbroker/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/msbroker/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/rhsso/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/rhsso/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/webapp/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/webapp/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/suites/integreatly/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/suites/integreatly/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/suites/integration/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/suites/integration/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/keycloak/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/keycloak/ga/discovery.yaml

#OpenShift Cluster Jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/create/openshift-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/deprovision/openshift-cluster-deprovision.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-uninstall.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-test.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/brew/openshift-cluster-brew-image-sync.yaml

#Delorean Folders
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/delorean/folders.yaml

#Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/after-first-login-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/alerts-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/all-tests-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/amq-online-address-creation-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/browser-based-single-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/browser-based-testsuite-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/customer-admin-permissions-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/delorean-testing-nightly-trigger.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/fuse-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/installation-smoke-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/launcher-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/msb-integration-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/nexus-builds-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/pds-uninstall.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/poc-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/poc-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/poc-uninstall.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/psi-clean-uninstall.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/recreate-pipelines.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/sso-user-create.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/w1-test-executor.yaml

#Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/repos/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/release/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/delorean/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/openshift/
