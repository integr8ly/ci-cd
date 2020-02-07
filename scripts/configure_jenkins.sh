#!/bin/sh

# Exit on error
set -e
# Verbose output of cmds
# set -x

SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CONFIG="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"

alias jenkins-jobs="docker run --env PYTHONHTTPSVERIFY=0 --privileged --rm -v $SCRIPTS_DIR/..:$SCRIPTS_DIR/.. docker-registry.upshift.redhat.com/jenkins-csb-intly-jjb/jenkins-job-builder:latest jenkins-jobs"

generate_inline_script_job() {
  $SCRIPTS_DIR/generate_inline_script_pipeline_job -j $1 -o $SCRIPTS_DIR/../jobs/generated
}

rm -rf $SCRIPTS_DIR/../jobs/generated/*

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

#Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

#utils
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/utils/polarion-reporter.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/utils/recreate-pipelines.yaml

#Integreatly-QE jobs - OpenShift 3

#Delorean nightly trigger
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/delorean-testing-nightly-trigger.yaml

#PDS
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-install-master-node.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-install.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-testing-executor.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/pds/pds-uninstall-master-node.yaml
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
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/slb-test.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/test-suites/update-sourcecode-test.yaml

#tower
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/integr8ly/ocp3/tower/tower-clean-uninstall.yaml


#Integreatly-QE jobs - OpenShift 4
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/install/image-deploy/openshift4-rhmi-image-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/install/olm/openshift4-rhmi-olm-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/nightly/executor/osd-ocp4-testing-executor.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/nightly/trigger/olm/osd-ocp4-olm-testing-nightly-trigger.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/nightly/trigger/master/osd-ocp4-master-testing-nightly-trigger.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/utils/htpasswd/openshift4-htpasswd-setup.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/integr8ly/ocp4/tests/executor/ocp4-all-tests-executor.yaml

#Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/openshift/
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/osd/

#Configure Delorean Jobs, Folders and Views
$SCRIPTS_DIR/configure_delorean.sh $CONFIG
