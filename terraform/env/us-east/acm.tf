module "acm_us_east_1" {
  source                    = "../../modules/acm"
  domain_name               = "*.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"
  route53_zone_id           = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  subject_alternative_names = ["*.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"]
  certificate_name          = "DarthDataDitch Wildcard Certificate US East 1"
}

output "acm_us_east_1_arn" {
  description = "The ARN of the ACM certificate for us-east-1"
  value       = module.acm_us_east_1.certificate_arn
}




