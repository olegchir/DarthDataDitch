variable "region" {
    type        = string
    default     = "us-east-1"  
}

variable "profile" {
    type        = string
    default     = "jb-testtask"
}

variable "eks_alb_sa" {
    type        = string
    default     = "system:serviceaccount:default:aws-ddload-balancer-controller"
}

