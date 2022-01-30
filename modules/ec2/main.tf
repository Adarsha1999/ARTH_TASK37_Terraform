resource "aws_instance" "web" {
  count = var.public_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.public_subnet_id
  vpc_security_group_ids = ["${aws_security_group.WS-SG.id}"]

  tags = {
    Name = "Public-Instance-${count.index+1}"
  }
}
resource "aws_instance" "web1" {
  count = var.private_instance_count
  ami           = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.private_subnet_id
  vpc_security_group_ids = ["${aws_security_group.WS-SG.id}"]

  tags = {
    Name = "Private-Instance-${count.index+1}"
  }
}

