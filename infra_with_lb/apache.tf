resource "aws_instance" "apache" {

  ami           = var.ami
  instance_type = var.micro-instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet1[0].id

  security_groups = [aws_security_group.apache-sg.id]
  user_data       = file("apache.sh")

  tags = {
    Name = "apache"
  }
}
