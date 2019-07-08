# Deploy Jenkins

## Table of Contents
  - [1. Prerequisites](#prerequisites)
  - [2. Deploy on OpenShift](#deploy-on-openshift)


## Prerequisites
- OpenShift 3.x Cluster (oc login)

## Deploy on OpenShift

To deploy a new jenkins instance on openshift, it is preferable to utilize the provided templates
We have created a shell-script that creates a project and deploys the templates in order

```
PROJECT_NAME=cicd ./scripts/deploy_jenkins.sh
```