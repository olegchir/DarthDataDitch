module "acm_eu_central_1" {
  source                    = "../../modules/acm"
  domain_name               = "eu.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"
  route53_zone_id           = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  subject_alternative_names = ["*.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"]
  certificate_name          = "DarthDataDitch Wildcard Certificate eu central 1"
}

output "acm_eu_central_1_arn" {
  description = "The ARN of the ACM certificate for eu central 1"
  value       = module.acm_eu_central_1.certificate_arn
}


