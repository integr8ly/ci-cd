
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

## Deploy a new image

After making a change to the base image configuration in your repo, trigger a new deployment of the image stream in order to deploy those changes by:

. Navigating to [openshift ci](https://api.ci.openshift.org/console/project/integr8ly/browse/builds)
. Choosing the relevant image
. Clicking on the `Start Build` button


## Image Mirroring for built integreatly images

For information on image-mirroring (aka pushing images to quay after building images and running prow test(s)) see [this section](https://github.com/openshift/release/tree/master/core-services/image-mirroring) in the openshift release documentation.

We've already done [some setup](https://github.com/openshift/release/pull/6766) to add the heimdall-operator to image-mirroring. To add your repo add an additional mapping file to [this folder](https://github.com/openshift/release/tree/master/core-services/image-mirroring/integr8ly) based on openshift release documtenation linked above.

### Credentials

To add your repo, update integreatly+prow robot to have read/write access to the repo.

You shouldn’t need to add further credentials as the [integreatly+prow robot](https://quay.io/organization/integreatly?tab=robots)’s credentials are already sent to the DPTP team for [inclusion in ci](https://github.com/openshift/release/pull/6773/files).

If for some reason you do need to add credentials for another account/bot, here are the steps:

Ping @testplatform-team in the #forum-testplatform channel on slack. Tell them that you want to submit credentials to Bitwarden and to send you a public gpg key to encrypt it.

Add their key using `gpg —import <sharedpublickey>.pub`

Download the dockerconfig credentials from quay.io for the account/bot you are using.

Encrypt the file using `gpg --output <outputfile> --encrypt --recipient <user-id> <dockerconfig>.json`

Once encrypted send the file and the DPTP team member will take care of adding it to Bitwarden.
