variable "cluster_name" {
  type        = string
}

variable "eks_role_arn" {
  type        = string
}

variable "subnet_ids" {
  type        = list(string)
}

variable "node_role_arn" {
  type        = string
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
}

variable "security_group_id" {
  type        = string
}

variable "node_desired_size" {
  type        = number
  default     = 1
}

variable "node_max_size" {
  type        = number
  default     = 2
}

variable "node_min_size" {
  type        = number
  default     = 1
}