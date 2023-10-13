# Deployment Requirements
1. Master Yoda once advised, 'Install these tools, you must, before deploying from your instance'
- [Helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
2. Before launching from the Death Star, ensure your AWS cli is configured on the command console.
2. Get EKS context - ``aws eks --region <region-code> update-kubeconfig --name <cluster-name> for each regions``
2. Get needed configuration parameters from infrastructure and build steps and fill "values-`$[eu,us]`.yaml" in `helm/darthdataditch`:
- `EKS cluster name` - Don't pull a Jar Jar! Know your deployment zone.
- `ALBC_ROLE` it is used for provisioning AWS Network Load Balancer
- `VPC_ID` - VPC Ids 1 for each region
- `image.repository:` - Your ECR repo
- `image.tag:`- version of the application code to be deployed
- `service.eipId:` - 2 eip id for each region
- `service.subnets:` - 2 subnetid for each region
- `acmCertificateArn:` - 2 arns to SSL Certificates
- `pod.annotations.eks.amazonaws.com/role-arn:` - AWS role attached to pods to access to bucket
- `env.S3_BUCKET_NAME:` - bucket name for application
- `env.USER_TOKENS` - coma separated list of creds for access to `/upload` e.g `USER_TOKENS="user1:bcryptSaltedHash,user2:bcryptSaltedHash"
## setup nlb to EKS
1. [deployment.sh](deployment.sh) will do this job for your if it is configured correctly