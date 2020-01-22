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

###Delorean Jobs

generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/misc/github-events/github-events.yaml

##Delorean 1.0 Early Warning System Jobs

generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/3scale/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/3scale/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/3scale/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/3scale/rc/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/amq-online/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/amq-online/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/amq-online/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/amq-online/rc/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/backup-container/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/backup-container/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/codeready/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/codeready/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/fuse/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/fuse/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/fuse-online/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/fuse-online/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/fuse-online/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/fuse-online/rc/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/gitea/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/gitea/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/middleware-monitoring/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/middleware-monitoring/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/msbroker/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/msbroker/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/rhsso/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/rhsso/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/webapp/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/webapp/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/suites/integreatly/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/suites/integreatly/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/suites/integration/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/suites/integration/rc/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/datasync-template/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/datasync-template/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/ups/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/ups/ga/discovery.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/mobile-walkthrough/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/ews/mobile-walkthrough/ga/discovery.yaml

#Delorean 1.0 OpenShift Cluster Jobs

#Cloud Services Team ToDo Refactor these to use the shared jobs
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/create/openshift-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/deprovision/openshift-cluster-deprovision.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-uninstall.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/integreatly/openshift-cluster-integreatly-test.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/openshift/cluster/brew/openshift-cluster-brew-image-sync.yaml

#Shared
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/cluster/openshift/integreatly/openshift-cluster-integreatly-install.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/cluster/openshift/integreatly/openshift-cluster-integreatly-uninstall.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/cluster/openshift/brew/openshift-cluster-brew-image-sync.yaml

#Cloud Services Team
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/team/cloud-services/cluster/openshift/openshift-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/team/cloud-services/cluster/openshift/openshift-cluster-destroy.yaml

#3Scale Team
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/team/3scale/cluster/openshift/openshift-cluster-create.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/1.0/team/3scale/cluster/openshift/openshift-cluster-destroy.yaml

##Delorean Folders
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/delorean/folders.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/delorean/1.0/folders.yaml
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/delorean/2.0/folders.yaml

###Generated jobs
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../jobs/generated/

###Views
jenkins-jobs --conf $CONFIG update $SCRIPTS_DIR/../views/delorean/
