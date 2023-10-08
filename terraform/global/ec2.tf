# temporary build box for because my personal is on arm
# Retrieve the latest debian-10 AMI
data "aws_ami" "latest_debian_ami" {
  most_recent = true

  filter {
    name   = "name"
    values = ["debian-10-amd64-*"]
  }
  owners = ["amazon"]
}

resource "aws_key_pair" "akononov_key" {
  key_name   = "akononov-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "build" {
  ami           = data.aws_ami.latest_debian_ami.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_ssh_build.name]
  key_name = aws_key_pair.akononov_key.key_name

  tags = {
    Name     = "build",
    managedby = "terraform"
  }
}

resource "aws_eip" "build-ip" {
  instance = aws_instance.build.id
}

resource "aws_security_group" "allow_ssh_build" {
  name_prefix = "allow-ssh-"
  
  # Ingress rules
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Default egress rule
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_route53_record" "build" {
  zone_id = aws_route53_zone.darthdataditch.zone_id
  name    = "build"
  type    = "A"
  ttl     = "300"
  records = [aws_eip.build-ip.public_ip]
}

output "instance_public_ip" {
  value = aws_instance.build.public_ip
}

output "dns_name" {
  value = aws_route53_record.build.fqdn
}
