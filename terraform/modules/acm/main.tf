resource "aws_acm_certificate" "certificate" {
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = []

  tags = {
    Name      = var.certificate_name,
    managedby = "terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_route53_record" "certificate_validation" {
  for_each = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
    }
  }

  name    = each.value.name
  type    = "CNAME"
  zone_id = var.route53_zone_id
  records = [each.value.record]
  ttl     = 60
}

output "certificate_arn" {
  value = aws_acm_certificate.certificate.arn
}

output "validation_record_fqdns" {
  value = aws_acm_certificate.certificate.domain_validation_options
}
