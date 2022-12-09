resource "aws_instance" "jeknins" {

  ami           = var.ami
  instance_type = var.micro-instance_type
  key_name      = var.key_name
  subnet_id     = aws_subnet.private_subnet1[1].id

  security_groups = [aws_security_group.jenkins-sg.id]
  user_data       = file("jenkins.sh")

  tags = {
    Name = "jenkins"
  }
}
