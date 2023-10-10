resource "aws_eks_cluster" "this" {
  name       = var.cluster_name
  role_arn   = var.eks_role_arn
  tags = {
    managedby = "vader"
  }

vpc_config {
    subnet_ids = var.subnet_ids
    security_group_ids = [var.security_group_id]
  }
}

output "eks_oidc_url" {
  value = aws_eks_cluster.this.identity.0.oidc.0.issuer
  
}

resource "aws_eks_node_group" "this" {
  count             = 2
  cluster_name      = aws_eks_cluster.this.name
  node_group_name   = "${var.cluster_name}-node-group-${count.index}"
  node_role_arn     = var.node_role_arn
  subnet_ids        = [var.subnet_ids[count.index]]
  instance_types    = [var.instance_type]
  scaling_config {
    desired_size = var.node_desired_size
    max_size     = var.node_max_size
    min_size     = var.node_min_size
  }
  tags = {
    managedby = "vader"
  }
}

output "eks_cluster_name" {
  value = aws_eks_cluster.this.name
}
