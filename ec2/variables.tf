variable "project_name" {}

variable "message" {}

variable "public_key_name" {}

variable "instance_count" {}

variable "instance_type" {}

variable "security_group" {}

variable "subnets" {
  type = "list"
}
