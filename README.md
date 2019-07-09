# ci-cd
Continuous Integration / Continuous Delivery related bits

## Table of contents
- [1. Jenkins Job Builder](#1-jenkins-job-builder)
  - [1.1 Installation](#11-installation)
    - [1.1.1 Linux](#111-linux)
    - [1.1.2 Mac](#112-mac)
  - [1.2 Configuration of JJB](#12-configuration-of-jjb)
  - [1.3 Test your template](#13-test-your-template)
  - [1.4 Update your job](#14-update-your-job)
  - [1.5 Generate inline script jobs](#15-generate-inline-script-jobs)
  - [1.6 Configure all jobs and views](#16-configure-all-jobs-and-views)
  - [1.7 Troubleshooting](#17-troubleshooting)
- [2. Delorean](#2-delorean)
  - [2.1 Contributing](#21-contributing)

## 1. Jenkins Job Builder
Job definitions are stored in form of templates for [Jenkins Job Builder](https://docs.openstack.org/infra/jenkins-job-builder/) (JJB). 

### 1.1 Installation

#### 1.1.1 Linux
Go to https://docs.openstack.org/infra/jenkins-job-builder/ and follow the instructions.

#### 1.1.2 Mac
Install jjb using Brew:

`brew install jenkins-job-builder`

### 1.2 Configuration of JJB
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

### 1.3 Test your template
```
jenkins-jobs --conf /path/to/your/jenkins_jobs.ini test /path/to/your/template.yaml
```

### 1.4 Update your job
```
jenkins-jobs --conf /path/to/your/jenkins_jobs.ini update /path/to/your/template.yaml
```

### 1.5 Generate inline script jobs
```
./scripts/generate_inline_script_pipeline_job -j /path/to/your/template.yaml -o /path/to/your/generated/jobs
```

### 1.6 Configure all jobs and views
```
./scripts/configure_jenkins /path/to/your/jenkins_jobs.ini
```

### 1.7 Troubleshooting
To prevent from getting SSL: CERTIFICATE_VERIFY_FAILED when running jenkins-jobs commands:
`ssl.SSLCertVerificationError: [SSL: CERTIFICATE_VERIFY_FAILED] certificate verify failed: self signed certificate in certificate chain`

execute the following command in the terminal:

```
export PYTHONHTTPSVERIFY=0
```

## 2. Delorean

All documentation related to Delorean are located [here](docs/README.md)

### 2.1 Contributing

Please open a Github issue in this repository for any bugs or problems you encounter.

If you encounter any issues with the Ansible Tower tooling, please open a Github issue [here](https://github.com/integr8ly/ansible-tower-configuration).