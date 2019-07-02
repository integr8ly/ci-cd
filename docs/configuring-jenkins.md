# Configuring Jenkins

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
A host vars file must be created for each Jenkins host.
```sh
cp inventories/host_vars/jenkins-host.template inventories/host_vars/<jenkins-host>.yaml
```

### Group Vars
Configure the `inventories/group_vars/all/credentials.yaml` file. This contains all the configuration and credentials required by the Delorean jobs.

## Running the script
```sh
ansible-playbook -i inventories/hosts playbooks/configure_jenkins.yaml
```

### Plugins Installation
The list of plugins that will be installed by the script can be seen in the `plugins.txt` file.

**NOTE**: Plugin installation can take a long time to finish. The logs for this task can be seen in the docker container running in your local machine. This is created by the ansible script and uses the image `jenkins-plugin-install`.

```sh
docker ps
docker container logs <container_id> -f
```

