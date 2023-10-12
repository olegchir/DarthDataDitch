# Deployment Requirements
1. Master Yoda once advised, 'Install these tools, you must, before deploying from your instance'
- [Helm](https://helm.sh/docs/intro/install/)
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
1. Before launching from the Death Star, ensure your AWS cli is configured on the command console.
1. Get EKS context - ``aws eks --region <region-code> update-kubeconfig --name <cluster-name> for each regions``
1. Get needed configuration parameters from infrastructure and build steps and fill values-`$[region]`.yaml in `helm/darthdataditch`:
- `EKS cluster name` - Don't pull a Jar Jar! Know your deployment zone.
- `ARN of alb-ingress-controller role` it is used for provisioning AWS Network Load Balancer
- `VPC ID` - VPC Ids 1 for each region
- `image.repository:` - Your ECR repo
- `image.tag:`- version of the application code to be deployed
- `service.eipId:` - 2 eip id for each region
- `service.subnets:` - 2 subnetid for each region
- `acmCertificateArn:` - 2 arns to SSL Certificates
- `pod.annotations.eks.amazonaws.com/role-arn:` - AWS role attached to pods to access to bucket
- `env.S3_BUCKET_NAME:` - bucket name for application
## setup nlb to EKS
1. Install aws load ballancer to EKS in each region
```
helm repo add eks https://aws.github.io/eks-charts

```

```
helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
    --set clusterName=eks-cluster-$(AWS_REGION) \
    --set serviceAccount.create=true \
    --set serviceAccount.name=aws-ddload-balancer-controller \
    --set region=${AWS_REGION} \
    --set vpcId=${VPC_ID} \
    --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=${ALB_ROLE}
```
