## Delorean Early Warning System

## Table of Contents
  - [1. Job Structure](#job-structure)
  - [2. Job Types](#job-types)
    - [2.1 GA](#ga)
    - [2.2 RC](#rc)
    - [2.3 latest](#latest)
  - [3. Jobs](#jobs)
    - [3.1 Discovery](#discovery)
    - [3.2 Branch](#branch)

### Job Structure

```
jobs/delorean/                                                                                                                                                                                                                                                                            
├── <product name>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
│   └── <job type>                                                                                                                                                                                                                                                                                
│       ├── branch.yaml                                                                                                                                                                                                                                                                   
│       └── discovery.yaml 
├── suites
│   └── <suite name>
│       └── <job type>
│           └── branch.yaml
```

### Job Types

Delorean can be configured with any number of different job types per product. 
These jobs represent a different kind of product release and can be one of, but not limited to, GA, RC and latest.

#### GA

GA jobs represent the latest stable release of the product. 
These would be considered complete and therefore updated/tested and merged as soon as possible. 

#### RC

RC jobs represent the most recent, if any, pre release version of the product. 
These would be discovered prior to a new GA being created. These would not be considered stable, but ready for initial testing to limit any potential issues when the GA version of the product is finally released. 

#### latest

latest jobs represent the latest development version of the product.

### Jobs

#### Discovery

A discovery jobs role is to search for new relevant versions of a particular product based on the desired job type (GA,RC,latest etc..)
It has the following responsibilities:
* Discovery of new versions based on the desired job type.
* Create a new branch against the installer if one does not already exist (<product-name>-<job type> i.e. 3scale-ga)
* Rebase base branch into product branch (master -> 3scale-ga) 
* Update appropriate variables in manifest with the new version (https://github.com/integr8ly/installation/blob/master/inventories/group_vars/all/manifest.yaml#L9)
* Push branch

#### Branch

A branch jobs role is to carry out any tasks required against a particular installation branch (i.e. 3scale-ga) when changes are made to it.
The tasks that are executed will depend on the job type (GA, RC etc..), but might include:
* Open PR against installation repo (GA only)
* Add jira for product update (GA only)
* Run integration tests
