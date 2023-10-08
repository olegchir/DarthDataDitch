module "alb_eip" {
  source = "../../modules/eip"
  eip_name = "alb-eip"
}

output "alb_eip_address" {
  value       = module.alb_eip.eip_address
}

output "alb_eip_allocation_id" {
  value       = module.alb_eip.eip_allocation_id
}