
resource "aws_db_instance" "mysql_5" {
  allocated_storage    = 20
  identifier           = "zeus-db-instance"
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.44"
  instance_class       = "db.t3.micro"
  multi_az             = false
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  db_name              = "webappdb"
  username             = "foo"
  password             = var.secret_string
  skip_final_snapshot  = true

  vpc_security_group_ids = [
    var.security_group_id_dbtier
  ]
  tags = var.tags

}


resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_id_private
}