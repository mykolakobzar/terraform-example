output "vpc_subnets" {
  value = aws_subnet.subnets.*.id
}

output "security_group" {
  value = aws_security_group.sg.id
}