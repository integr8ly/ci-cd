# Configuring Jenkins

## Table of Contents
  - [1. Prerequisites](#1-prerequisites)
  - [2. Configuring the inventory](#2-configuring-the-inventory)
    - [2.1 Host File](#host-file)
    - [2.2 Host Vars](#host-vars)
    - [2.3 Credentials and Global Settings](#credentials-and-global-settings)
  - [3. Running the Script](#4-running-the-script)
    - [3.1 Plugins Installation](#plugins-installation)
    - [3.2 Potential Issues During Configuraiton](#potential-issues-during-configuration)

## Prerequisites
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#intro-installation-guide)
- [Docker](https://docs.docker.com/install/overview)


The `configure_jenkins` playbook and all of its required files for inventory and roles are located in the `scripts/` folder.

```sh
cd scripts/
```
## Configuring the inventory
The inventory files must be configured before the script can be run.

### Host File
Create the `hosts` file
```sh
cp inventories/hosts.template inventories/hosts
```

### Host Vars
A host vars file must be created for each Jenkins host. This will contain the Jenkins configuration (i.e. credentials) used to connect to the target Jenkins instance.
```sh
cp inventories/host_vars/jenkins-host.template inventories/host_vars/<jenkins-host>.yaml
```

### Credentials and Global Settings
Configure the `inventories/group_vars/all/credentials.yaml` file. This contains all the configuration for global settings and credentials required by the Delorean jobs.

## Running the script
```sh
ansible-playbook -i inventories/hosts playbooks/configure_jenkins.yaml
```

### Plugins Installation
Plugin installation can take a long time to finish. The logs for this task can be seen in the docker container running in your local machine. This is created by the ansible script and uses the image `jenkins-plugin-install`.

```sh
docker ps
docker container logs <container_id> -f
```

### Potential Issues During Configuration
Preflight checks are run before creating any resources on the target Jenkins instance.

#### Conflicting Credentials
Credentials defined in the [credentials.yaml](../../scripts/inventories/group_vars/all/credentials.yaml) file will be created by the configuration script. Any existing credentials with the same credential ID will be overwritten. A warning will appear during the configuration process if any existing credentials are found and the user will be asked to confirm to continue the process.

#### Incompatible Plugins
The list of plugins that will be installed by the script, along with their target versions, can be found in the [plugins.txt](../../scripts/plugins.txt) file.

Any plugins that are already available in the Jenkins instance, won't be re-installed or updated. This may cause the Delorean jobs to not work as expected. A warning will appear during the configuration process if any incompatible plugins were found and the user will be asked to confirm to continue the process.

#### Plugin Dependency Errors
Dependency Errors may occur after plugin installation. This is required to be fixed manually.

If any dependency errors were found, a notification will appear during the configuration process and the user will be asked to ensure that these dependency errors are fixed and the plugins affected by these errors are properly loaded before continuing the process.

Any dependency errors that are not fixed may cause the configuration process to fail.


