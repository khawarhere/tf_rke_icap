variable "region" {
}

variable "profile" {
}


variable "instance_type" {
  default = "t2.large"
}

variable "cluster_id" {
  default = "rke"
}

variable "docker_install_url" {
  default = "https://releases.rancher.com/install-docker/19.03.sh"
}

variable "common_tags" {
}