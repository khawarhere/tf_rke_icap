# Input variable definitions

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_region" {

}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
}

variable "subnets_public_cidr" {
  type        = string
  default     = "10.0.101.0/24"
}

variable "common_tags" {
  description = "Tags to apply to all resources created"
  type        = map(string)
  default = {
    Terraform   = "true"
  }
}
