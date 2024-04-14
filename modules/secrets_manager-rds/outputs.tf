
output "secretARN" {
  description = "arn of secret string"
  value       = aws_secretsmanager_secret_version.secret.arn
}

