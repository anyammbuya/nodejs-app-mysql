variable "tags" {
  description = "tags"
}

variable "kms_key_id" {
  description = "Kms key id"
}

variable "security_group_id_dbtier" {
  description = "Security group ID for dbtier"
  
}
variable "subnet_id_private" {
  description = "Subnet ID for Private EC2 instances"

}

variable "project_name" {
  description = "project name"
  default     = "zeus"
}

