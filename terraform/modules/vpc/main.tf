data "aws_availability_zones" "available" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name,
    managedby = "vader"
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/eks-cluster-eu-central-1" = "owned" ##TODO should be auto generation
  }
}

output "vpc_id" {
  value = aws_vpc.main.id
}

resource "aws_subnet" "this" {
  count                   = 2
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.subnet_cidr_blocks[count.index]
  availability_zone       = element(data.aws_availability_zones.available.names, count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.subnet_name_prefix}-${element(data.aws_availability_zones.available.names, count.index)}",
    managedby = "vader",
    "kubernetes.io/role/elb" = "1"
    "kubernetes.io/cluster/eks-cluster-eu-central-1" = "owned"  

  }

}

output "subnet_ids" {
  value       = aws_subnet.this.*.id
}

output "cidr_block" {
  value = var.cidr_block
}
