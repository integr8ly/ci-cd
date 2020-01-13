# Local Development Setup for testing Jenkins Jobs in integreatly-qe-jenkins

The steps below will get you (fairly) quickly set up for local development on the jenkins jobs located in this folder. This  allows you to test the changes on integreatly-qe-jenkins. Things get reset to master daily but remember: with great power comes great responsibility.


## Pre-req

- Admin access on [integreatly-qe-jenkins](https://integreatly-qe-jenkins.rhev-ci-vms.eng.rdu2.redhat.com/) - contact the delorean team channel on gchat
- [pyyaml](https://pypi.org/project/PyYAML/) 

## Create jenkins config file

In the root of your local ci-cd repo paste the following into a new file `jenkins-config.ini` replacing username and password with your credentials from [here](https://integreatly-qe-jenkins.rhev-ci-vms.eng.rdu2.redhat.com/me/) -> Configure -> Show Api Token using  `User ID` for <username> and `API Token` for <password>
 
```
[job_builder]
ignore_cache=True
keep_descriptions=False
include_path=.:scripts:~/git/
recursive=False
exclude=.*:manual:./development
allow_duplicates=False

[jenkins]
url = https://integreatly-qe-jenkins.rhev-ci-vms.eng.rdu2.redhat.com
user = <username>
password = <password>
query_plugins_info=False
```

## Make a copy of the job you want to test

Example steps:

Copy 
`jobs/delorean/fuse-online/ga/discovery.yaml`
to 
`jobs/delorean/fuse-online/ga/discovery-test.yaml`

Append `-test` to job `name` and job `display-name` in the new test file.

Make the required changes to this file or the related Jenkinsfile (search for `script-path` in the yaml file)
In the example case that is:
`jobs/delorean/jenkinsfiles/discovery/ga/Jenkinsfile`

## Sync the new job to Jenkins

### Update script

In scripts/configure_jenkins_test.sh Uncomment the line to include the path to your `-test.yaml` file

### Sync the changes
To sync this new job or new changes to the job run:

```
./scripts/configure_jenkins_test.sh ./scripts/jenkins-config.ini
```
 
You should see a new job or existing job updated with the name provided in the yaml file.

