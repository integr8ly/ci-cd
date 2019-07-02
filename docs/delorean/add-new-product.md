## Add new product

The following document outlines the steps required to add a new product to the Delorean early warning system.

### Job Types

At a minimum GA discovery and branch jobs should be added, but the same steps can be applied for adding RC or latest job types if required. 

Create the following directory/file structure for the new product jobs:

```jobs/delorean/                                                                                                                                                                                                                                                                            
   ├── <new product name>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
   │   └── ga                                                                                                                                                                                                                                                                                
   │       ├── branch.yaml                                                                                                                                                                                                                                                                   
   │       └── discovery.yaml 
```

### Implement branch.yaml

Overview of the branch jobs function can be found [here](early-warning-system.md#branch)

Copy the [template branch job](../../jobs/delorean/job-templates/ga/branch.yaml), into the correct product directory [here](../../jobs/delorean) 

Update any paramaters values marked as "REQUIRED": 

| Paramater | Required | Description|
| --- | --- | --- |
| installationGitUrl | Y | The installation repo |
| installationProductBranch | Y | The installation git branch to push new version changes |
| productName | Y | Product to check, this affects the way the job verifies if a new version is available|
| productVersionVar | Y | The manifest variable to be used as the current component version |

### Implement discovery.yaml

Overview of the discovery jobs function can be found [here](early-warning-system.md#discovery)

Copy the [template discovery job](../../jobs/delorean/job-templates/ga/discovery.yaml), into the correct product directory [here](../../jobs/delorean) 

Update any paramaters values marked as "REQUIRED": 

| Paramater | Required | Description|
| --- | --- | --- |
| productVersionVar | Y | The manifest variable to be used as the current component version |
| projectOrg | Y | The github project organization |
| projectRepo | Y | The github project repository |
| productName | Y | Product to check, this affects the way the job verifies if a new version is available|
| releaseFetchMethod | N | Method to fetch latest release which can either be by tag or by release |
| gaReleaseTagRef | N | Reference used to filter GA releases from the repository tags |
| releaseTagVar | N | The manifest variable to be used as the current component version |
| productVersionLocation | N | Path to the file where the product version of the component is declared |
| productVersionIdentifier | N | Identifier to be used to retrieve the product version from the productVersionLocation |

### Add new product folders

Update the delorean [folders.yaml](../../jobs/delorean/folders.yaml) config to include the new product.

Add the following:

```
# <Product Name>
- job:
    name: delorean-<product-name>
    display-name: '<Product Name>'
    project-type: folder
- job:
    name: delorean-<product-name>/ga
    display-name: 'GA'
    project-type: folder 
```
### Update configuration script

Update the [configure_jenkins](../../scripts/configure_jenkins.sh) script to include the new jobs.

Add the following under the "#Delorean Jobs" section:

```
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/<product-name>/ga/branch.yaml
generate_inline_script_job $SCRIPTS_DIR/../jobs/delorean/<product-name>/ga/discovery.yaml
```
