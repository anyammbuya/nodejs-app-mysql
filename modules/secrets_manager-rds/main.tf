
resource "random_password" "master_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_db_instance" "mysql_5" {
  allocated_storage           = 20
  identifier                  = "zeus-db-instance"
  storage_type                = "gp2"
  engine                      = "mysql"
  engine_version              = "5.7.44"
  instance_class              = "db.t3.micro"
  multi_az                    = false
  db_subnet_group_name        = aws_db_subnet_group.db_subnet_group.name
  db_name                     = "webappdb"
  username                    = "admin"
  password                    = random_password.master_password.result
  skip_final_snapshot         = true
  vpc_security_group_ids      = [var.security_group_id_dbtier]
  tags                        = var.tags
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnet_id_private
}


data "aws_db_instance" "mysql_db"{
  db_instance_identifier   = aws_db_instance.mysql_5.identifier

}

resource "aws_secretsmanager_secret" "rds_credentials" {
  kms_key_id              = var.kms_key_id
  name                    = "rds_credentials"
  description             = "RDS Admin password"
  recovery_window_in_days = 0

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "secret" {
  secret_id     = aws_secretsmanager_secret.rds_credentials.id
  secret_string = <<EOF
{
  "username": "${data.aws_db_instance.mysql_db.master_username}",
  "password": "${random_password.master_password.result}",
  "host": "${data.aws_db_instance.mysql_db.address}"
  
}
EOF
}
