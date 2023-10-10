variable "cidr_block" {
  description = "On the desert plains of Tatooine, the CIDR hologram points to the VPC's oasis."
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "Decoded from R2-D2's beeps, a sequence of CIDR codes for the droid's subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_name" {
  description = "Inscribed by Jedi Masters, the name glyph for the VPC star cruiser."
  type        = string
}

variable "subnet_name_prefix" {
  description = "Glowing in the hue of a lightsaber, the prologue for the subnet's saber-tag."
  type        = string
  default     = "subnet"
}

variable "tag_cluster_name" {
  type = map(string)
  default = {}
}
