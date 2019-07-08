# ci-cd
Continuous Integration / Continuous Delivery related bits

## Jenkins Job Builder
Job definitions are stored in form of templates for [Jenkins Job Builder](https://docs.openstack.org/infra/jenkins-job-builder/) (JJB). 

### Installation

#### Linux
Go to https://docs.openstack.org/infra/jenkins-job-builder/ and follow the instructions.

#### Mac
Install jjb using Brew:

`brew install jenkins-job-builder`

### Configuration of JJB
Create `jenkins_job.ini` file containing
```
[job_builder]
ignore_cache=True
keep_descriptions=False
include_path=.:../scripts:~/git/
recursive=False
allow_duplicates=False

[jenkins]
user=<YOUR_USERNAME>
password=<YOUR_PASSWORD>
url=<YOUR_JENKINS_INSTANCE_URL>
query_plugins_info=False
```

### Test your template
```
jenkins-jobs --conf /path/to/your/jenkins_jobs.ini test /path/to/your/template.yaml
```

### Update your job
```
jenkins-jobs --conf /path/to/your/jenkins_jobs.ini update /path/to/your/template.yaml
```

### Generate inline script jobs
```
./scripts/generate_inline_script_pipeline_job -j /path/to/your/template.yaml -o /path/to/your/generated/jobs
```

### Configure all jobs and views
```
./scripts/configure_jenkins /path/to/your/jenkins_jobs.ini
```

### Troubleshooting
To prevent from getting SSL: CERTIFICATE_VERIFY_FAILED when running jenkins-jobs commands:
`ssl.SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self signed certificate in certificate chain`

execute the following command in the terminal:

```
export PYTHONHTTPSVERIFY=0
```

## Delorean

All documentation related to Delorean are located [here](docs/README.md)

### Support

Please open a Github issue in this repository for any bugs or problems you encounter.

If you encounter any issues with the Ansible Tower tooling, please open a Github issue [here](https://github.com/integr8ly/ansible-tower-configuration).