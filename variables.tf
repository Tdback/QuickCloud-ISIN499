variable "public_subnet" {
  description = "Public subnet CIDRs for the ALB and NAT instances."
  type        = list(string)
  default     = []
}

variable "private_server" {
  description = "Private subnets CIDRs for the EC2 instances."
  type        = list(string)
  default     = []
}

variable "private_db" {
  description = "Private subnet CIDRs for the SQL databases."
  type        = list(string)
  default     = []
}

variable "server_name" {
  description = "Generic names for EC2 instances."
  type        = list(string)
  default     = []
}

variable "private_ips" {
  description = "IPs for EC2 instances."
  type        = list(string)
  default     = []
}

variable "eips" {
  description = "Elastic IPs for NAT instances."
  type        = list(string)
  default     = []
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "type" {
  description = "Instance type for EC2 instances."
  type        = string
}

variable "db_username" {
  description = "Username for database administrator."
  type        = string
}

variable "db_engine" {
  description = "Engine for RDS instance."
  type        = string
}

variable "db_engine_version" {
  description = "Specified version for RDS engine."
  type        = string
}

variable "db_instance_class" {
  description = "Type of RDS instance."
  type        = string
}

variable "db_port" {
  description = "Port for database requests/responses."
  type        = number
}
