resource "aws_route53_record" "us-east-cluster" {
  zone_id = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  name    = "us.darthdataditch.jftr.info."
  type    = "A"
  ttl     = "300"
  records = [module.alb_eip.eip_address]
}