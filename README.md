# ci-cd
Continuous Integration / Continuous Delivery related bits

## Jenkins Job Builder
Job definitions are stored in form of templates for [Jenkins Job Builder](https://docs.openstack.org/infra/jenkins-job-builder/) (JJB).

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
