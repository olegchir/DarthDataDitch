variable "domain_name" {
  type        = string
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
