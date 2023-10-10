module "alb_eip-a" {
  source = "../../modules/eip"
  eip_name = "alb-eip-${var.region}-a"
}

output "alb_eip_address" {
  value       = module.alb_eip.eip_address
}

output "alb_eip_allocation_id" {
  value       = module.alb_eip.eip_allocation_id
}


module "alb_eip-b" {
  source = "../../modules/eip"
  eip_name = "alb-eip-${var.region}-b"
}

output "alb_eip_address" {
  value       = module.alb_eip-b.eip_address
}

output "alb_eip_allocation_id" {
  value       = module.alb_eip-b.eip_allocation_id
}