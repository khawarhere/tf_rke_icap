variable "region" {}

variable "instance_type" {}

variable "cluster_id" {}

variable "docker_install_url" {
  default = "https://releases.rancher.com/install-docker/19.03.sh"
//  default = "https://get.docker.com"
}

variable "common_tags" {}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.110.0.0/16"
}

variable "subnet_public_cidr" {
  type        = string
  default     = "10.110.1.0/24"
}
