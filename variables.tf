variable "Environment" {
  description = "The environment for the infrastructure"
  type        = string
  default     = "Test"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.1.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "The CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.1.0.0/21", "10.1.8.0/21"]
}

variable "private_subnet_cidrs" {
  description = "The CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.1.3.0/24", "10.1.4.0/24"]
}
