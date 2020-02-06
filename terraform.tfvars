aws_region = "us-east-1"
project_name = "assessment_test"
vpc_cidr     = "10.10.0.0/16"
subnets_cidr = [
  "10.10.1.0/24",
  "10.10.2.0/24",
  "10.10.3.0/24"
]
access_ips    = "0.0.0.0/0"

public_key_name = "assessment_test_key"

instance_type = "t2.micro"

instance_count = 1

message = "Hei der!"

