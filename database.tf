#subnet group for database
resource "aws_db_subnet_group" "database-subnet-1" {
  name = "subnet-group"
  subnet_ids = [ aws_subnet.public-subnet-1.id, aws_subnet.public-subnet-2.id ]
}

#create database
resource "aws_db_instance" "db-1" {
  allocated_storage = 20
  identifier        = "rds-terraform"
  storage_type      = "gp2"
  engine            = "mysql"
  engine_version    = "8.0.27"
  instance_class    = "db.t2.micro"
  db_name           = "maxime_db"
  username          = "maxime"
  password          = "maximefrankefort"
  publicly_accessible    = true
  skip_final_snapshot    = true
  db_subnet_group_name = aws_db_subnet_group.database-subnet-1.name
  

  tags = {
    Name = "db-1"
  }
}