terraform {
  required_providers {
    rke = {
      source = "rancher/rke"
      version = "1.2.1"
    }
  }
}

provider "rke" {
  debug = true
  log_file = "rke_debug.log"
}

module "nodes" {
  source = "./node"
  region = var.region
  instance_type = var.instance_type
  cluster_id = var.cluster_id
  common_tags = var.common_tags
}

resource "rke_cluster" "cluster" {
  cloud_provider {
    name = "aws"
  }

  nodes {
    address = module.nodes.internal_ips[0]
    internal_address = module.nodes.internal_ips[0]
    user = "ubuntu"
    ssh_key = file("~/.ssh/icap_us-e1_key.pem")
    role    = ["controlplane", "etcd"]
  }
  nodes {
    address = module.nodes.public_ips[1]
//    address = module.nodes.internal_ips[1]
    internal_address = module.nodes.internal_ips[1]
    user = "ubuntu"
    ssh_key = file("~/.ssh/icap_us-e1_key.pem")
    role = ["worker"]
  }
//  nodes {
//    address = module.nodes.public_ips[2]
//    internal_address = module.nodes.internal_ips[2]
//    user = "ubuntu"
//    ssh_key = file("~/.ssh/icap_us-e1_key.pem")
//    role = ["worker"]
//  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "./kube_config_cluster.yml"
  content = rke_cluster.cluster.kube_config_yaml
}

