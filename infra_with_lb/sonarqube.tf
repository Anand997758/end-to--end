resource "aws_instance" "sonarqube" {
  ami             = var.ubuntu-ami
  instance_type   = var.medium-instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.private_subnet1[2].id
  security_groups = [aws_security_group.sonarqube-sg.id]
  user_data       = file("sonarqube-ubuntu.sh")
  tags = {
    Name = "sonarqube"
  }
}