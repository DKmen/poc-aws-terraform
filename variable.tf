variable "aws_project" {
  type        = string
  default     = "project"
  description = "Define AWS Project"
  nullable    = false
}

variable "aws_region" {
  type        = string
  default     = "us-west-2"
  description = "Define AWS Region"
  nullable    = false
}

variable "aws_vpc_name" {
  type        = string
  default     = "vpc"
  description = "Define VPC Name"
}

variable "aws_vpc_cidr" {
  type        = string
  default     = "10.0.0.0/16"
  description = "Define VPC CIDR Block"
}
