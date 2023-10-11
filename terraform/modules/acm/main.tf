resource "aws_acm_certificate" "certificate" {
  provider = aws.this
  domain_name       = var.domain_name
  validation_method = "DNS"
  subject_alternative_names = var.subject_alternative_names
  tags = {
    Name      = var.certificate_name,
    managedby = "vader"
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  validation_records = {
    for dvo in aws_acm_certificate.certificate.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
    }
  }

  filtered_records = var.create_route53_record ? local.validation_records : {}
}

resource "aws_route53_record" "certificate_validation" {
  for_each = local.filtered_records

  provider = aws.this
  name     = each.value.name
  type     = "CNAME"
  zone_id  = var.route53_zone_id
  records  = [each.value.record]
  ttl      = 60

  lifecycle {
    ignore_changes = [records]
    create_before_destroy = true
  }
}

output "certificate_arn" {
  value = aws_acm_certificate.certificate.arn
}

output "validation_record_fqdns" {
  value = aws_acm_certificate.certificate.domain_validation_options
}
