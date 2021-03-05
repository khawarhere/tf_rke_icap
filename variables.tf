# Input variable definitions
variable "common_tags" {
  description = "General Tags to apply to resources created"
  type        = map(string)
  default = {
    Service = "ICAP Cluster"
    Owner   = "Furqan"
    Delete  = "Yes"
    Team    = "DevOps"
    Scope   = "Created for icap demo"
    Terraform   = "Yes"
  }
}

variable "region" {
  default     = "eu-west-3"
}

variable "profile" {
  default = "gw"
}
