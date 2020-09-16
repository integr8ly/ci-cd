
# OpenShift CI

The integeratly prow jobs are configured to use a base image containing all the tools required to build and execute the tests. In order to keep builds speedy, we use an image stream for the base image in the integr8ly namespace on [openshift ci](https://api.ci.openshift.org/console/project/integr8ly/browse/images) 

## Create Image Streams

```bash
oc new-app -p IMAGE_NAME=<image stream name> -p GITHUB_ORG=<github org name> -p GITHUB_REPO=<github repo name> -p GITHUB_REF=<git ref> -f openshift-ci/templates/base-image-build-template.yml -n integr8ly
```

Integreatly Operator

```bash
oc new-app -p IMAGE_NAME=intly-operator-base-image -p GITHUB_ORG=integr8ly -p GITHUB_REPO=integreatly-operator -p GITHUB_REF=master -f openshift-ci/templates/base-image-build-template.yml -n integr8ly
```

Heimdall Operator

```bash
oc new-app -p IMAGE_NAME=heimdall-base-image -p GITHUB_ORG=integr8ly -p GITHUB_REPO=heimdall -p GITHUB_REF=master -f openshift-ci/templates/base-image-build-template.yml -n integr8ly
```

Cloud Resource Operator

```bash
oc new-app -p IMAGE_NAME=cro-base-image -p GITHUB_ORG=integr8ly -p GITHUB_REPO=cloud-resource-operator -p GITHUB_REF=master -f openshift-ci/templates/base-image-build-template.yml -n integr8ly
```

RHMI Utils

```bash
oc new-app -p IMAGE_NAME=managed-api-utils-base-image -p GITHUB_ORG=integr8ly -p GITHUB_REPO=rhmi-utils -p GITHUB_REF=master -f openshift-ci/templates/base-image-build-template.yml -n integr8ly
```

## Deploy a new image

After making a change to the base image configuration in your repo, trigger a new deployment of the image stream in order to deploy those changes by:

. Navigating to [openshift ci](https://api.ci.openshift.org/console/project/integr8ly/browse/builds)
. Choosing the relevant image
. Clicking on the `Start Build` button
