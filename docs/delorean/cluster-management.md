# Cluster Management

## Table of Contents
  - [1. Overview](#overview)
  - [2. Ansible Tower](#ansible-tower)
  - [3. Creating PoC Clusters](#creating-poc-clusters)
    - [3.1 Accessing the Cluster](#accessing-the-cluster)
      - [3.1.1 Cluster Admin Credentials](#cluster-admin-credentials)
  - [4. Installing Integreatly](#installing-integreatly)
  - [5. Uninstalling Integreatly](#uninstalling-integreatly)
  - [6. Deprovisioning PoC Clusters](#deprovisioning-poc-clusters)
  - [7. Syncing Brew Images](#syncing-brew-images)

## Overview
The following document outlines how you can provision/deprovision PoC clusters and install/uninstall Integreatly.

All of the cluster management jobs can be found under the `OpenShift` tab in Jenkins and are defined in the [jobs/openshift/cluster/](../../jobs/openshift/cluster/) directory.

## Ansible Tower
The Delorean cluster management sends requests to Ansible Tower to launch workflows for provisioning/deprovisioning PoC clusters and installing/uninstalling Integreatly. For further information on these workflows, see the Ansible Tower [documentation](https://github.com/integr8ly/ansible-tower-configuration/blob/master/README.md).

## Creating PoC Clusters
PoC clusters can be provisioned by building the `Openshift Cluster Create` pipeline which is defined in the [jobs/openshift/cluster/create/](../../jobs/openshift/cluster/create/) directory.

This pipeline launches the `Provision Cluster` workflow in Ansible Tower. For more information about this workflow, see the [cluster create](https://github.com/integr8ly/ansible-tower-configuration#46-cluster-create) documentation.

To run this pipeline on Jenkins:
1. Go to the `OpenShift` tab
2. Select the `OpenShift Cluster Create` pipeline
3. Build the pipeline with the following parameters


| Parameter             | Description                                   | Required |
| --------------------- | --------------------------------------------- |:--------:|
| clusterName           | Name of the cluster to create                 |  Y       |
| awsRegion             | Region where the cluster will be created in   |  Y       |
| awsAccountName        | AWS Account to use                            |  Y       |    
| master_instance_type  | Instance type of the master node              |  Y       |      
| compute_instance_type | Instance type of the compute node             |  Y       |   
| infra_instance_type   | Instance type of the infra node               |  Y       |       
| master_group_size     | Amount of master node(s) to be created        |  Y       |       
| compute_group_size    | Amount of computer node(s) to be created      |  Y       |         
| infra_group_size      | Amount of infra node(s) to be created         |  Y       |       
| dryRun                | Will only print what the job will do          |  N       |     

**NOTE**:
- The `awsAccountName` is the name of the AWS credential configured in Ansible Tower. To configure this in Ansible Tower, please follow this [guide](https://github.com/integr8ly/tower_dummy_credentials/blob/master/VARIABLES.md#aws_credentials).

### Accessing the cluster
After a successful provision, the cluster information will be available in the post install job in Ansible Tower.

1. Select the `Openshift Cluster Create` job that you just built
2. Go to `Console Output`
3. Go to the link of the `Post_install` job

The following cluster details should be displayed:
- Console URL (`https://<clusterName>.<domain>.com`)
- Cluster Admin Username
- Master Node IP Address

#### Cluster Admin Credentials
The cluster admin credentials should be available in the credentials project configured in Ansible Tower. 

1. Login to Ansible Tower
2. Go to `Projects`
3. Select the `Ansible Tower Credentials Project`
4. Go to the repository and branch specified as the source of the credentials project
5. Go to `inventories/group_vars/all/cluster.yml` file
   
   The cluster admin credentials should be available as `htpasswd_username` and `htpasswd_password`

For more information on the credentials project, see this [guide](https://github.com/integr8ly/tower_dummy_credentials/blob/master/VARIABLES.md).

## Installing Integreatly
Integreatly can be installed to an existing PoC cluster by building the `OpenShift Cluster Integreatly Install` pipeline which is defined in the [jobs/openshift/cluster/integreatly/](../../jobs/openshift/cluster/integreatly/) directory.

This pipeline launches the `Integreatly Install Workflow` in Ansible Tower. For more information about this workflow, see the [Integreatly install](https://github.com/integr8ly/ansible-tower-configuration#44-integreatly-install) documentation.

To run this pipeline on Jenkins:
1. Go to the `OpenShift` tab
2. Select the `OpenShift Cluster Integreatly Install` pipeline
3. Build the pipeline with the following parameters


| Parameter             | Description                                                 | Required |
| --------------------- | ------------------------------------------------------------|:--------:|
| clusterName           | Name of the cluster to install Integreatly against          |  Y       |
| openshiftMasterUrl    | Public URL of the OpenShift cluster                         |  Y       |
| clusterAdminUsername  | Username of the cluster admin account                       |  N       |    
| clusterAdminPassword  | Password of the cluster admin account                       |  N       |      
| installationGitUrl    | Git repo URL of the Integreatly installer                   |  Y       |   
| installationGitBranch | Git branch where the Integreatly installer is located       |  Y       |       
| userCount             | Number of users to pre-seed in the environment              |  N       |       
| selfSignedCerts       | Set to true if the OpenShift cluster uses self-signed certs |  N       |         
| dryRun                | Will only print what the job will do                        |  N       | 

**NOTES**:
- To find the `openshiftMasterUrl`, please see the [accessing the cluster](#accessing-the-cluster) guide
- The `clusterAdminUsername` and `clusterAdminPassword` should be available in the credentials project configured in Ansible Tower. To get these credentials, please see this [guide](#cluster-admin-credentials).

  If no values are specified, it defaults to the username and password stored in a Jenkins credential called `tower-openshift-cluster-credentials`. This credential is set during Jenkins configuration. For more information on how to set this, please see the [configuring jenkins](./configuring-jenkins#credentials-and-global-settings) guide.
  
## Uninstalling Integreatly
Integreatly can be uninstalled on an existing PoC cluster with Integreatly installed by building the `OpenShift Cluster Integreatly Uninstall` pipeline which is defined in the [jobs/openshift/cluster/integreatly/](../../jobs/openshift/cluster/integreatly/) directory.

This pipeline launches the `Integreatly Uninstall Workflow` in Ansible Tower. For more information about this workflow, see the [Integreatly uninstall](https://github.com/integr8ly/ansible-tower-configuration#45-integreatly-uninstall) documentation.

To run this pipeline on Jenkins:
1. Go to the `OpenShift` tab
2. Select the `OpenShift Cluster Integreatly Uninstall` pipeline
3. Build the pipeline with the following parameters

| Parameter             | Description                                                 | Required |
| --------------------- | ------------------------------------------------------------|:--------:|
| clusterName           | Name of the cluster to uninstall Integreatly from           |  Y       |
| openshiftMasterUrl    | Public URL of the OpenShift cluster                         |  Y       |
| clusterAdminUsername  | Username of the cluster admin account                       |  N       |    
| clusterAdminPassword  | Password of the cluster admin account                       |  N       |      
| installationGitUrl    | Git repo URL of the Integreatly uninstaller                 |  Y       |   
| installationGitBranch | Git branch where the Integreatly uninstaller is located     |  Y       |
| dryRun                | Will only print what the job will do                        |  N       | 

**NOTES**:
- To find the `openshiftMasterUrl`, please see the [accessing the cluster](#accessing-the-cluster) guide
- The `clusterAdminUsername` and `clusterAdminPassword` should be available in the credentials project configured in Ansible Tower. To get these credentials, please see this [guide](#cluster-admin-credentials).

  If no values are specified, it defaults to the username and password stored in a Jenkins credential called `tower-openshift-cluster-credentials`. This credential is set during Jenkins configuration. For more information on how to set this, please see the [configuring jenkins](./configuring-jenkins#credentials-and-global-settings) guide.


## Deprovisioning PoC Clusters
PoC clusters can be deprovisioned by building the `Openshift Cluster Deprovision` pipeline which is defined in the [jobs/openshift/cluster/deprovision/](../../jobs/openshift/cluster/deprovision/) directory.

This pipeline launches the `Deprovision Cluster` workflow in Ansible Tower. For more information about this workflow, see the [cluster deprovision](https://github.com/integr8ly/ansible-tower-configuration#47-cluster-deprovision) documentation.

To run this pipeline on Jenkins:
1. Go to the `OpenShift` tab
2. Select the `OpenShift Cluster Deprovision` pipeline
3. Build the pipeline with the following parameters


| Parameter             | Description                                   | Required |
| --------------------- | --------------------------------------------- |:--------:|
| clusterName           | Name of the cluster to deprovision            |  Y       |
| awsRegion             | Region where the cluster was created          |  Y       |
| awsAccountName        | AWS Account to use                            |  Y       |    
| clusterDomainName     | Domain name used by the provisioned cluster   |  Y       |    
| dryRun                | Will only print what the job will do          |  N       |     

**NOTE**:
- The `awsAccountName` is the name of the AWS credential configured in Ansible Tower. To configure this in Ansible Tower, please follow this [guide](https://github.com/integr8ly/tower_dummy_credentials/blob/master/VARIABLES.md#aws_credentials).

## Syncing Brew Images

Product images used for RC releases are located in an internal registry called Brew. In order to use the product templates during the installation, the images defined in the templates needs to be available in the OpenShift cluster's internal registry. These images are listed in the `integreatly.yml` file located in the given RC branch which is generated during the discovery of an RC release.

The `OpenShift Cluster Brew Image Sync` pipeline must be ran before any Integreatly installation for RC branches. Any images found in the `integreatly.yml` file will be copied from an internal Brew registry to the cluster's internal registry, making the images used in the product templates available in the target OpenShift cluster for installation.

**IMPORTANT**: 
- Since the images used for RC releases are located in an internal registry, this job must be run on a Red Hat internal network.

This job is defined in the [jobs/openshift/cluster/brew/](../../jobs/openshift/cluster/brew/) directory.

To run this pipeline on Jenkins:
1. Go to the `OpenShift` tab
2. Select the `OpenShift Cluster Brew Image Sync` pipeline
3. Build the pipeline with the following parameters

| Parameter             | Description                                                   | Required |
| --------------------- | --------------------------------------------------------------|:--------:|
| clusterName           | Name of the cluster to sync the images  against               |  Y       |
| openshiftMasterUrl    | Public URL of the OpenShift cluster                           |  Y       |
| clusterAdminUsername  | Username of the cluster admin account                         |  N       |    
| clusterAdminPassword  | Password of the cluster admin account                         |  N       |      
| installationGitUrl    | Git repo URL of the Integreatly installer                     |  Y       |   
| installationGitBranch | The RC Git branch to be used for the Integreatly installation |  Y       |
| dryRun                | Will only print what the job will do                          |  N       | 

**NOTES**:
- To find the `openshiftMasterUrl`, please see the [accessing the cluster](#accessing-the-cluster) guide
- The `clusterAdminUsername` and `clusterAdminPassword` should be available in the credentials project configured in Ansible Tower. To get these credentials, please see this [guide](#cluster-admin-credentials).

  If no values are specified, it defaults to the username and password stored in a Jenkins credential called `tower-openshift-cluster-credentials`. This credential is set during Jenkins configuration. For more information on how to set this, please see the [configuring jenkins](./configuring-jenkins#credentials-and-global-settings) guide.