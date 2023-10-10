## Pre-created EIP for using with AWS NLB
module "alb_eip_a" {
  source = "../../modules/eip"
  eip_name = "alb-eip-${var.region}-a"
}

output "alb_eip_address_a" {
  value       = module.alb_eip_a.eip_address
}

output "alb_eip_allocation_id_a" {
  value       = module.alb_eip_a.eip_allocation_id
}


module "alb_eip_b" {
  source = "../../modules/eip"
  eip_name = "alb-eip-${var.region}-b"
}

output "alb_eip_address_b" {
  value       = module.alb_eip_b.eip_address
}

output "alb_eip_allocation_id_b" {
  value       = module.alb_eip_b.eip_allocation_id
}