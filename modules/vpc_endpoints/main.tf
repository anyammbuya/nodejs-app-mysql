resource "aws_vpc_endpoint" "secretsmanager-endpt" {
  vpc_id                  = var.vpc_id
  vpc_endpoint_type       = "Interface"
  security_group_ids      = [var.vpc_endpoint_sg_id]
  subnet_ids              = var.subnet_ids
  private_dns_enabled     = true
  service_name            = "com.amazonaws.${var.region}.secretsmanager"
}

/*
resource "aws_vpc_endpoint" "ssm-endpt" {
  vpc_id                 = var.vpc_id
  vpc_endpoint_type      = "Interface"
  security_group_ids     = [var.vpc_endpoint_sg_id]
  subnet_ids             = var.subnet_ids
  private_dns_enabled    = true
  service_name           = "com.amazonaws.${var.region}.ssm"
}

resource "aws_vpc_endpoint" "ssmmsgs-endpt" {
  vpc_id                 = var.vpc_id
  vpc_endpoint_type      = "Interface"
  security_group_ids     = [var.vpc_endpoint_sg_id]
  subnet_ids             = var.subnet_ids
  private_dns_enabled    = true
  service_name = "com.amazonaws.${var.region}.ssmmessages"
}

resource "aws_vpc_endpoint" "cloudwatch-logs-endpt" {
  vpc_id                   = var.vpc_id
  vpc_endpoint_type        = "Interface"
  security_group_ids       = [var.vpc_endpoint_sg_id]
  subnet_ids               = var.subnet_ids
  private_dns_enabled      = true
  service_name             = "com.amazonaws.${var.region}.logs"
}

resource "aws_vpc_endpoint" "ec2msgs-endpt" {
  vpc_id                   = var.vpc_id
  vpc_endpoint_type        = "Interface"
  security_group_ids       = [var.vpc_endpoint_sg_id]
  subnet_ids               = var.subnet_ids
  private_dns_enabled      = true
  service_name             = "com.amazonaws.${var.region}.ec2messages"
}
*/