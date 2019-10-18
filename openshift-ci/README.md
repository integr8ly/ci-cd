
# OpenShift CI

The integeratly prow jobs are configured to use a [base image](https://github.com/openshift/release/blob/master/ci-operator/config/integr8ly/integreatly-operator/integr8ly-integreatly-operator-master.yaml#L25) 
containing all the tools required to build and execute the tests. In order to keep builds speedy, we use an image stream for the base image in the integr8ly namespace on [openshift ci](https://api.ci.openshift.org/console/project/integr8ly/browse/images/intly-base-image) 

## Create Image Stream

```bash
oc new-app -p GITHUB_ORG=integr8ly -p GITHUB_REF=master -f openshift-ci/templates/base-image-build-template.yml -n integr8ly
```
