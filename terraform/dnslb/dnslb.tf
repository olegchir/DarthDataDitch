resource "aws_route53_record" "geolocation_us_east" {
  zone_id = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  name    = "${var.geodns-name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${data.terraform_remote_state.us-east.outputs.dns_us-east-cluster-host}"]

  set_identifier = "US-EAST-ENDPOINT"

  geolocation_routing_policy {
    continent = "NA"
  }

  health_check_id = aws_route53_health_check.us_east.id
}

resource "aws_route53_record" "geolocation_eu_central" {
  zone_id = data.terraform_remote_state.global.outputs.darthdataditch_zone_id
  name    = "${var.geodns-name}"
  type    = "CNAME"
  ttl     = "300"
  records = ["${data.terraform_remote_state.eu-central.outputs.dns_eu-central-cluster-host}"]

  set_identifier = "EU-CENTRAL-ENDPOINT"

  geolocation_routing_policy {
    continent = "EU"
  }

  health_check_id = aws_route53_health_check.eu_central.id
}

resource "aws_route53_health_check" "us_east" {
  fqdn              = data.terraform_remote_state.us-east.outputs.dns_us-east-cluster-host
  port              = 443
  type              = "HTTPS"
  resource_path     = "/healthcheck"
  failure_threshold = 3
  request_interval  = 30
}

resource "aws_route53_health_check" "eu_central" {
  fqdn              = data.terraform_remote_state.eu-central.outputs.dns_eu-central-cluster-host
  port              = 443
  type              = "HTTPS"
  resource_path     = "/healthcheck"
  failure_threshold = 3
  request_interval  = 30
}

