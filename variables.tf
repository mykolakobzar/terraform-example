variable "aws_region" {}

variable "project_name" {}

variable "vpc_cidr" {}

variable "subnets_cidr" {
  type = list
}

variable "access_ips" {}

variable "public_key_name" {}

variable "instance_count" {}

variable "instance_type" {}

variable "message" {}