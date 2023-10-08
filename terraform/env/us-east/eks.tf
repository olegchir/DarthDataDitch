module "us_east_eks" {
  source            = "../../modules/eks"
  cluster_name      = "eks-cluster-${var.region}"
  eks_role_arn      = data.terraform_remote_state.global.outputs.eks_cluster_role_arn
  subnet_ids        = module.us_east_vpc.subnet_ids
  node_role_arn     = data.terraform_remote_state.global.outputs.eks_node_role_arn
  security_group_id = aws_security_group.eks_cluster_sg.id
}
