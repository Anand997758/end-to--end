resource "aws_instance" "elk" {
  ami             = var.ubuntu-ami
  key_name        = var.key_name
  instance_type   = var.medium-instance_type
  subnet_id       = aws_subnet.private_subnet1[2].id
  security_groups = [aws_security_group.elk-sg.id]
  user_data       = file("elk.sh")
  tags = {
    Name = "elk"
  }
}