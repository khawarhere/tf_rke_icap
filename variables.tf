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

variable "cluster_id" {
  default     = "rke_khawar"
}

variable "instance_type" {
  default     = "t2.xlarge"
}

variable "region" {}
