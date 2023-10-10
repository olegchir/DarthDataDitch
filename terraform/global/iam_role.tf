# # EKS Cluster Role
# resource "aws_iam_role" "eks_cluster_role" {
#   name = "eks-cluster-role"
#   tags = {
#     managedby = "vader"
#   }
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "eks.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_eks_cluster_policy" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_cluster_amazon_eks_service_policy" {
#   role       = aws_iam_role.eks_cluster_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
# }

# output "eks_cluster_role_arn" {
#   value       = aws_iam_role.eks_cluster_role.arn
# }

# # EKS Node Group Role
# resource "aws_iam_role" "eks_node_role" {
#   name = "eks-node-role"
#   tags = {
#     managedby = "vader"
#   }
#   assume_role_policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Action = "sts:AssumeRole",
#         Effect = "Allow",
#         Principal = {
#           Service = "ec2.amazonaws.com"
#         }
#       }
#     ]
#   })
# }

# resource "aws_iam_role_policy_attachment" "eks_node_amazon_eks_worker_node_policy" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# }

# resource "aws_iam_role_policy_attachment" "eks_node_amazon_eks_cni_policy" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# }

# resource "aws_iam_role_policy_attachment" "eks_node_amazon_ec2_container_registry_read_only" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# }

# resource "aws_iam_role_policy_attachment" "eks_node_s3_policy_attachment" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = aws_iam_policy.s3_holocron-archives_policy.arn
# }

# resource "aws_iam_role_policy_attachment" "eks_node_ssm_managed_instance_core" {
#   role       = aws_iam_role.eks_node_role.name
#   policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
# }

# output "eks_node_role_arn" {
#   value       = aws_iam_role.eks_node_role.arn
# }
# output "eks_node_role_name" {
#   value       = aws_iam_role.eks_node_role.name
# }


  

