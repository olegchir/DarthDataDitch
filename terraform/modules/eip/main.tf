resource "aws_eip" "this" {
  tags = {
    Name      = var.eip_name,
    managedby = "vader"
  }
}

output "eip_address" {
  value       = aws_eip.this.public_ip
}

output "eip_allocation_id" {
  value       = aws_eip.this.allocation_id
}
