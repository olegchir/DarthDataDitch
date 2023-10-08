module "us_east_vpc" {
  source             = "../../modules/vpc"
  cidr_block         = "10.100.0.0/16"
  subnet_cidr_blocks = ["10.100.1.0/24", "10.100.2.0/24"]
  vpc_name           = "${var.region}-vpc"
  subnet_name_prefix = "${var.region}-subnet"
}

output "us_east_vpc_id" {
  value = module.us_east_vpc.vpc_id
}
  
output "us_east_subnet_ids" {
  value = module.us_east_vpc.subnet_ids
}

resource "aws_internet_gateway" "igw" {
  vpc_id = module.us_east_vpc.vpc_id
  tags = {
    managedby = "vader"
  }
}

resource "aws_route_table" "public" {
  vpc_id = module.us_east_vpc.vpc_id
  tags = {
    managedby = "vader"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public_a" {
  subnet_id      = module.us_east_vpc.subnet_ids[0]
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = module.us_east_vpc.subnet_ids[1]
  route_table_id = aws_route_table.public.id
}


