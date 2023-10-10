# DarthDataDitch
## build dependencies
1. aws cli
1. docker
1. helm
1. kubectl
## Deployment dependencies
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

