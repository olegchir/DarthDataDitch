module "eu_central_eks" {
  source            = "../../modules/eks"
  cluster_name      = "eks-cluster-${var.region}"
  eks_role_arn      = aws_iam_role.eks_cluster_role.arn
  subnet_ids        = module.eu_central_vpc.subnet_ids
  node_role_arn     = aws_iam_role.eks_node_role.arn
  security_group_id = aws_security_group.eks_cluster_sg.id
  instance_type     = "t2.medium"
}

data "aws_caller_identity" "eu_central_eks" {}


data "external" "eks_thumbprint" {
  program = ["scripts/thumbprint.sh"]
  query = {
    cluster_name = module.eu_central_eks.eks_cluster_name
    region       = var.region
  }
}

resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [replace(lower(data.external.eks_thumbprint.result.thumbprint),":", "")]
  url             = module.eu_central_eks.eks_oidc_url
}
output "eks_oidc_url" {
  value = "arn:aws:iam::${data.aws_caller_identity.eu_central_eks.account_id}:oidc-provider/${replace(aws_iam_openid_connect_provider.eks_oidc.url, "https://", "")}"
}

resource "aws_eks_identity_provider_config" "eu_central_eks" {
  cluster_name = module.eu_central_eks.eks_cluster_name
  oidc {
    client_id = "sts.${var.region}.amazonaws.com"
    identity_provider_config_name = "eu_central_eks"
    issuer_url = module.eu_central_eks.eks_oidc_url
  }
}
