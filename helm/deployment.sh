#!/bin/bash
# This script is used to deploy the helm chart to the clusters

### Configuration
APP_VERSION="0.0.4"
ALBC_ROLE_EU="arn:aws:iam::433663489437:role/alb-ingress-controller-eu-central-1"
VPC_ID_EU="vpc-071184ccbca84c38a"
ALBC_ROLE_US="arn:aws:iam::433663489437:role/alb-ingress-controller"
VPC_ID_US="vpc-08d75a4f24bf1a3e2"

# Check and install  that helm repo for Amazon-load-balancer-controller presented on the deployment box
helm_repo_exists() {
    local repo_name="$1"
    helm repo list | grep -q "^$repo_name"
    return $?
}
if helm_repo_exists "eks"; then
    echo "Helm repo $1 exists. Continue..."
else
    echo "Enabling eks repo..."
    helm repo add eks https://aws.github.io/eks-charts
fi
# Configure access to the cluster
configure_k8s_access() {
    aws eks --region ${AWS_REGION} update-kubeconfig --name eks-cluster-${AWS_REGION}
    if [ $? -ne 0 ]; then
        echo "Error updating kubeconfig for region ${AWS_REGION} and EKS cluster eks-cluster-${AWS_REGION}."
        exit 1
    else
        echo "Kubeconfig updated successfully for region ${AWS_REGION} and EKS cluster eks-cluster-${AWS_REGION}."
    fi
}
# Check and install Amazon-load-balancer-controller presented on EKS
is_aws_lb_controller_running() { 
    local running_pods=$(kubectl get pods -l app.kubernetes.io/name=aws-load-balancer-controller --field-selector=status.phase=Running | grep -c "Running")
    if [ "$running_pods" -gt 0 ]; then
        echo "Amazon-load-balancer-controller is running. Continue..."
        return 0
    else
    echo "Attempting to install/upgrade Amazon-load-balancer-controller..."
    helm upgrade --install aws-load-balancer-controller eks/aws-load-balancer-controller \
      --set clusterName=eks-cluster-${AWS_REGION} \
      --set serviceAccount.create=true \
      --set serviceAccount.name=aws-ddload-balancer-controller \
      --set region=${AWS_REGION} \
      --set vpcId=${VPC_ID} \
      --set serviceAccount.annotations."eks\.amazonaws\.com/role-arn"=${ALBC_ROLE}
      if [ $? -ne 0 ]; then
            echo "Error installing/upgrading the Amazon-load-balancer-controller. Exiting."
            exit 1
        fi
        return 1
    fi
}

### Deploy DartHDataditch
deploy_darthdata_ditch() {
  CHART_VERSION=$($(grep 'appVersion:' darthdataditch/Chart.yaml | awk '{print $2}'))
  rm darthdataditch-*.tgz
  helm package darthdataditch/
  helm upgrade --install helmdataditch ./darthdataditch-${CHART_VERSION}.tgz  -f darthdataditch/values.yaml -f values-${DEPLOYMENT_REGION}.yaml
}

#### Deployment

if [ "$1" = "eu" ]; then
  AWS_REGION="eu-central-1"
  VPC_ID=${VPC_ID_EU}
  ALBC_ROLE=${ALBC_ROLE_EU}
  DEPLOYMENT_REGION="eu"
  echo "Deploying to eu-central-1..."
  is_aws_lb_controller_running
  configure_k8s_access



elif [ "$1" = "us" ]; then
    AWS_REGION="us-east-1"
    VPC_ID=${VPC_ID_US}
    ALBC_ROLE=${ALBC_ROLE_US}
    DEPLOYMENT_REGION="us"
    echo "Deploying to us-east-1..."
    if is_aws_lb_controller_running; then
        echo "aws-load-balancer-controller is running."
    else
        echo "aws-load-balancer-controller is not running."
    fi

else
    echo -e "Unknown flag provided. Exiting...\nPlease use 'eu', 'us', 'albc-eu', or 'albc-us'."
    exit 1
fi
