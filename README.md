# DarthDataDitch General cosidirations
Infrastructure utilize AWS resources and fully builded in IaaC approach. For deploying it is assuming that you already have aws account with the admin rights. and manually provision bucket for terraform state in this case it is `jb-tt-tf-state`, this code provided fully ready solution to have 2 redundand EKS clusters in 2 regions in this case us-east-1 and eu-central-1. It is assuming that you already have doman or zone and able to delegate ti to Route53 (it should be done on the side of your internet domain registrar). Application called `DarthDataDitch` builded with python and dockerized. The deployment should be done by helm package manager. Everything here buided to be fault tollerant to one AWS AZ or Region outage. More things you can read [here](https://docs.google.com/document/d/1_5W-mnQ0Ws0bq8gDrwcKPqiczHOUIyRVEaWobPW_bQk/edit)
# DarthDataDitch Infrastructure
Inrastructure provisioned in AWS by terraform and at the end you will have configured following
1. S3 bucket for data
1. Networking configurations
1. IAM policies and roles necessary for EKS
1. Route53 configuration for GeoBalancing
1. 2 EKS clusters in `US-EAST-1` and `EU-CENTRAL-1` regions
1. Set of prealocated EIPs associated with your application 2 in each Region
1. All outputs for app deployment configuration
## Code Organisation.
This terraform code organized with environments and modules
## Infrastructure Dependencies
## Order of execution
1. git clone this repository and make changes to terraform necessary for exact your setup, e.g. s3 buckets/domain names/etc
1. Provisioning global environment - `terraform init` and `terraform apply` in **global** environment
1. Provisioning regional environment - `terraform init` and `terraform apply` in **env/region** environment
1. Applying DNS changes for Geo Based DNS Load balancing - `terraform init` and `terraform apply` in **dnslb**




### build dependencies
1. aws cli
1. docker
1. helm
1. kubectl
### Deployment dependencies
1. Configure AWS cli to be able to access to AWS
1. Get EKS context - aws eks --region <region-code> update-kubeconfig --name <cluster-name>

## setup alb to EKS
helm upgrade -i aws-load-balancer-controller eks/aws-load-balancer-controller --set clusterName=<eks-cluster-name> --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --namespace kube-system


helm repo add eks https://aws.github.io/eks-charts``

helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --namespace kube-system \
    --set clusterName=eks-cluster-us-east-1 \
    --set serviceAccount.create=true \
    --set serviceAccount.name=aws-ddload-balancer-controller \
    --set region=us-east-1 \
    --set vpcId=vpc-0b7b590f4a44a5540 \
    --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=arn:aws:iam::433663489437:role/alb-ingress-controller


# Infrastructure
