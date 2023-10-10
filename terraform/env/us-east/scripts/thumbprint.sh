#!/bin/bash

CLUSTER_NAME="eks-cluster-us-east-1"
REGION="us-east-1"

eval "$(jq -r '@sh "CLUSTER_NAME=\(.cluster_name) REGION=\(.region)"')"

OIDC_ISSUER=$(aws eks describe-cluster --name ${CLUSTER_NAME} --region ${REGION} --query "cluster.identity.oidc.issuer" --output text)

THUMBPRINT=$(openssl s_client -servername oidc.eks.${REGION}.amazonaws.com -showcerts -connect oidc.eks.${REGION}.amazonaws.com:443 </dev/null 2>&1 | openssl x509 -fingerprint -noout -in /dev/stdin | cut -d= -f2)

echo "{ \"thumbprint\": \"$THUMBPRINT\" }"