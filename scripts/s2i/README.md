
# S2i Configuration

The directory holds configuration for building the jenkins container to host CI/CD for Integreatly,
as referenced from [openshift/jenkins Readme|https://github.com/openshift/jenkins#installing-using-s2i-build]

## Build a new image

```
s2i build ./scripts/s2i/ openshift/jenkins-2-centos7 quay.io/integreatly/jenkins-2-centos7
```