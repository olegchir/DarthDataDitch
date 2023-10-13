# DarthDataDitch Infrastructure
Inrastructure provisioned in AWS by terraform and at the end you will have configured following
1. S3 bucket for data
1. Networking configurations
1. IAM policies and roles necessary for EKS
1. Route53 configuration for GeoBalancing
1. 2 EKS clusters in ```US-EAST-1``` and ```EU-CENTRAL-1``` regions
1. Set of prealocated EIPs associated with your application 2 in each Region
1. All outputs for app deployment configuration
## Code Organisation.
This terraform code organized with environments and modules and this code utilise terraform remote states. All related AWS provisioning code located in **terroform** directory (Except code related to provisioning cloud load balancers. Cloud Load balancers provisioned on Application layer) of this git repo and structured as below.
```
|* env
|   |* eu-central
|   `* us-east
|       |* policies
|       `* scripts
|* global
|* dnslb
|* modules
    |* acm
    |* eip
    |* eks
    |* vpc
```
In the ```global``` environment you will bi find everythong necessary for initial AWS configuration. In the ```env/region-name``` all necessary for provisioning regions. ```env/region/policies``` needed for storing huge AWS policies for save some readability for code ```env/region/policies``` reseved for external scripts e.g. get data which are not supported by terraform directly but needed for the project.
Files which are startes with `_` are not making changes to infra directly. Now lets take a look on modules:
1. `modules/acm` - used for Amazon certificate manager configuration in each environment
1. `module/eip` - used for external ip allocation
1. `module/eks` - used for EKS cluster provisioning
1. `module/vpc` - used for regional vpc provisioning
All provisioned resources will be marked with tag `managedby = "vader"` 
## Infrastructure Dependencies
1. AWS and Access to it.
1. Configured `aws-cli`
1. Domain or zone with avialability to delegate it
1. Terraform version 1.6.0
## Order of applying
1. git clone this repository and make changes to terraform necessary for exact your setup, e.g. s3 buckets/domain names/etc
1. Provisioning global environment - `terraform init` and `terraform apply` in **global** environment
1. Provisioning regional environment - `terraform init` and `terraform apply` in **env/region** environment
1. Applying DNS changes for Geo Based DNS Load balancing - `terraform init` and `terraform apply` in **dnslb**
## Order of destroying
1. `terraform destroy` in **dnslb**
1. `terraform destroy` in **env/region** environments
1. `terraform destroy` in **global** environment
