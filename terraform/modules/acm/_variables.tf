variable "domain_name" {
  type        = string
  default     = "darthdataditch.jftr.info"
}

variable "subject_alternative_names" {
  type        = list(string)
  default     = []
}

variable "certificate_name" {
  type        = string
  default     = "ACM Certificate"
}

variable "route53_zone_id" {
  type        = string
}


variable "acm_region" {
  description = "List of regions to create the ACM certificate in"
  type        = string
}

variable "create_route53_record" {
  description = "Flag to determine whether to create the Route53 record or not"
  default     = true
}
