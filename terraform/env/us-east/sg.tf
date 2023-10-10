# ALB Security Group
resource "aws_security_group" "allow_alb" {
  vpc_id = module.us_east_vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [format("%s/32", module.alb_eip.eip_address)]
  }

  tags = {
    managedby = "vader"
    Name      = "alb"
  }
}

resource "aws_security_group" "eks_cluster_sg" {
  vpc_id      = module.us_east_vpc.vpc_id
  name        = "eks-cluster-sg"
  description = "Security group for EKS Cluster"

  tags = {
    Name = "eks-cluster-sg",
    managedy = "vader"
  }
}

resource "aws_security_group_rule" "eks_to_vpc" {
  security_group_id = aws_security_group.eks_cluster_sg.id

  type        = "ingress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [module.us_east_vpc.cidr_block]
}

resource "aws_security_group_rule" "vpc_to_eks" {
  security_group_id = aws_security_group.eks_cluster_sg.id

  type        = "egress"
  from_port   = 0
  to_port     = 65535
  protocol    = "tcp"
  cidr_blocks = [module.us_east_vpc.cidr_block]
}
