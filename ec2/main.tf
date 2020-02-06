data "aws_ami" "ubuntu" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }
}

resource "aws_key_pair" "ssh_key" {
  public_key = file("${path.module}/test-ssh-key/id_rsa.pub")
  key_name = var.public_key_name
}

data "template_file" "user-data" {
  template = file("${path.module}/user-init-data.tpl")
  vars = {
    hello_message = var.message
  }
}

resource "aws_instance" "instance" {
  count         = var.instance_count
  instance_type = var.instance_type
  ami           = data.aws_ami.ubuntu.id

  tags = {
    Name = "${var.project_name}-${count.index +1}"
  }

  key_name               = aws_key_pair.ssh_key.id
  vpc_security_group_ids = [var.security_group]
  subnet_id              = element(var.subnets, count.index)
  user_data              = data.template_file.user-data.*.rendered[count.index]
}