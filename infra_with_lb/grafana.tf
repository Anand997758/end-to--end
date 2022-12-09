resource "aws_instance" "grafana" {
  ami             = var.ami
  instance_type   = var.large-instance_type
  key_name        = var.key_name
  subnet_id       = aws_subnet.private_subnet1[0].id
  security_groups = [aws_security_group.grafana-sg.id]
  user_data       = file("grafana.sh")
  tags = {
    Name = "grafana"
  }

}