resource "aws_route53_record" "eu-central-cluster" {
  zone_id = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  name    = "eu.darthdataditch.jftr.info."
  type    = "A"
  ttl     = "300"
  records = [module.alb_eip_a.eip_address, module.alb_eip_b.eip_address]
}

output "dns_eu-central-cluster-host" {
  value = aws_route53_record.eu-central-cluster.name
  
}