variable "vpc_name" {
    type = string
    description = "Define VPC Name"
    nullable = false
}

variable "vpc_cidr" {
    type = string
    description = "Define VPC CIDR Block"
    nullable = false
}
