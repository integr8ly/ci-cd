
# Delorean

## Table of Contents
  - [1. Overview](#overview)
  - [2. Early Warning System](#early-warning-system)
    - [2.1 Release Discovery](#release-discovery)
    - [2.2 Adding New Products](#adding-new-products)
  - [3. Cluster Management](#cluster-management)
  - [4. Automated Tests](#automated-tests)
  - [5. Jenkins Configuration](#jenkins-configuration)

## Overview
Multiple products are installed as part of the Integreatly environment. It is important to move quickly to the new releases of these products to enable proof of concepts and ensure any new managed environment is always using the latest versions. The Delorean suite of jobs provides an automated way of discovering, updating and testing new versions of these products.

## Early Warning System
These products are configured to integrate with each other, therefore, it is important to receive early warnings of changes to the installation, configuration and functionality of each of these products.

### Release Discovery
Delorean provides discovery of latest releases for each of the products installed in the Integreatly environment. For further information on the different types of Delorean jobs, please go [here](delorean/early-warning-system.md).

### Adding New Products
Follow this [guide](delorean/add-new-product.md) on how to add new products to the Delorean early warning system.

## Cluster Management
The cluster management jobs enables you to create PoC clusters for installing and testing new versions of products in an Integreatly environment.

Follow this [guide](delorean/cluster-management.md) on how to provision PoC clusters and install Integreatly using the Delorean cluster management jobs.

## Automated Tests
TODO

## Jenkins Configuration
The Delorean jobs can be configured in any existing Jenkins instance. Follow this [guide](delorean/configuring-jenkins.md) on how to configure Delorean to an existing Jenkins instance.