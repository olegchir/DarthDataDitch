module "acm_wildecard_certificates_us" {
  source                    = "../modules/acm"
  domain_name               = "us.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"
  route53_zone_id           = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  acm_region                = "us-east-1"
  providers = {
    aws.this = aws.us-east-1
  }
  subject_alternative_names = [
    "*.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"
  ]
  certificate_name          = "DarthDataDitch Wildcard Certificate"
}

module "acm_wildecard_certificates_eu" {
  source                    = "../modules/acm"
  domain_name               = "eu.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"
  route53_zone_id           = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  acm_region                = "eu-central-1"
  providers = {
    aws.this = aws.eu-central-1
}
  subject_alternative_names = [
    "ddd.${data.terraform_remote_state.global.outputs.darthdataditch_zone_name}"
  ]
  certificate_name          = "DarthDataDitch Wildcard Certificate"
}

output "certificate_arn_us" {
  description = "The ARN of the ACM certificate for eu central 1"
  value       = module.acm_wildecard_certificates_us.certificate_arn
}

output "certificate_arn_eu" {
  description = "The ARN of the ACM certificate for eu central 1"
  value       = module.acm_wildecard_certificates_eu.certificate_arn
}
