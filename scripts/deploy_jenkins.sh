#!/bin/sh -xe
SCRIPTS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
TEMPLATES_DIR="$( cd $SCRIPTS_DIR/templates && pwd )"

oc new-project $PROJECT_NAME

for AGENT in jenkins-tools
do
    AGENT_LABELS="$AGENT ${AGENT/-/ } openshift"
    if [ "$AGENT" = "jenkins-tools" ] ; then
        AGENT_LABELS="jenkins-tools cirhos_rhel7"
    fi
    oc new-app -p AGENT_LABEL="$AGENT_LABELS" -p IMAGE_NAME=jenkins-agent-$AGENT -f  $TEMPLATES_DIR/agent-image-template.yml
done

oc new-app -f  $TEMPLATES_DIR/jenkins-image-template.yaml

# Adding create project access to system:serviceaccount:$PROJECT_NAME:jenkins
oc adm policy add-cluster-role-to-user self-provisioner system:serviceaccount:$PROJECT_NAME:jenkins
oc new-app -p MEMORY_LIMIT=2Gi -p NAMESPACE=$PROJECT_NAME -p JENKINS_IMAGE_STREAM_TAG=jenkins:latest -f  $TEMPLATES_DIR/jenkins-template.yml
oc import-image jenkins:latest -n $PROJECT_NAME
