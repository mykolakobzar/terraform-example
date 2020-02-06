data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "${var.project_name}_vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "${var.project_name}_igw"
  }
}

resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.project_name}_route_public"
  }
}

resource "aws_default_route_table" "private_route" {
  default_route_table_id  = aws_vpc.vpc.default_route_table_id

  tags = {
    Name = "${var.project_name}_route_private"
  }
}

resource "aws_subnet" "subnets" {
  count                   = 3
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.subnets_cidrs[count.index]
  map_public_ip_on_launch = true
  availability_zone       = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "${var.project_name}_subnet_${count.index + 1}"
  }
}

resource "aws_route_table_association" "route_association" {
  count          = length(aws_subnet.subnets)
  subnet_id      = aws_subnet.subnets.*.id[count.index]
  route_table_id = aws_route_table.public_route.id
}

resource "aws_security_group" "sg" {
  name        = "${var.project_name}_security_group"
  description = "Public Access Security Group"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.access_ips]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.access_ips]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}