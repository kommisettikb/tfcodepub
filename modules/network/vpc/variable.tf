variable "vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
}

variable "sub_cidr"{
    type = string
    default = "10.0.1.0/24"
}

#variable "az"{
#    type = list
#    default = ["ap-south-1a","ap-south-1b"]
#}