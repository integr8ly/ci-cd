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
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/datasync-template/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/datasync-template/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/ups/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/ups/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/mobile-walkthrough/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/mobile-walkthrough/ga/discovery.yaml

#OpenShift Cluster Jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/create/openshift-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/deprovision/openshift-cluster-deprovision.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-uninstall.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-test.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/brew/openshift-cluster-brew-image-sync.yaml

# OpenShit 4 Cluster jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/osd/cluster/create/osd-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/osd/cluster/deprovision/osd-cluster-deprovision.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift4/cluster/integreatly/openshift4-cluster-integreatly-install.yaml

# OSD cluster jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/osd-cluster-integreatly-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/osd-cluster-integreatly-upgrade.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/osd-cluster-integreatly-uninstall.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/osd-cluster-integreatly-test-upgrade.yaml

# OSDv3
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/osd/create-rhmi-user.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/osd/grant-3scale-admin-permissions.yaml

#Delorean Folders
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/delorean/folders.yaml

#Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

#utils
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/utils/recreate-pipelines.yaml

#Integreatly-QE jobs - OpenShift 3

#Delorean nightly trigger
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/delorean-testing-nightly-trigger.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/nightly/osd-testing-nightly-trigger.yaml

#PDS
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-uninstall.yaml

#POC
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/poc/poc-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/poc/poc-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/poc/poc-uninstall.yaml

#test-suites
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/after-first-login-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/alerts-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/all-tests-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/amq-online-address-creation-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/browser-based-single-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/browser-based-testsuite-pipeline.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/codeready-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/customer-admin-permissions-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/fuse-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/installation-smoke-tests.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/launcher-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/msb-integration-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/nexus-builds-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/sso-user-create.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/three-scale-restoration.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/w1-test-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/w2-test-executor.yaml

#tower
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/tower/tower-clean-uninstall.yaml


#Integreatly-QE jobs - OpenShift 4
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/install/openshift4-rhmi-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/nightly/executor/osd-ocp4-testing-executor.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/nightly/trigger/osd-ocp4-testing-nightly-trigger.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/utils/htpasswd/openshift4-htpasswd-setup.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/tests/executor/ocp4-all-tests-executor.yaml

#Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/repos/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/release/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/delorean/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/openshift/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/osd/
