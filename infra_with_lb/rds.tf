resource "aws_db_subnet_group" "db-subnetgroup" {
  name       = "db-subnetgroup"
  subnet_ids = [aws_subnet.datasubnet[0].id, aws_subnet.datasubnet[1].id, aws_subnet.datasubnet[2].id]

  tags = {
    Name = "rdssubnet-group"
  }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "mydb"
  username             = "sivadev"
  password             = "sriram2662"
  parameter_group_name = "default.mysql5.7"
  db_subnet_group_name = aws_db_subnet_group.db-subnetgroup.name
  skip_final_snapshot  = true
  tags = {
    "name" = "stage-rds"
  }