terraform {
  required_providers {
    rke = {
      source = "rancher/rke"
      version = "1.2.1"
    }
  }
}
module "nodes" {
  source = "./ec2"
  region        = var.region
  instance_type = var.instance_type
  cluster_id    = var.cluster_id
  common_tags = var.common_tags
}

resource "rke_cluster" "cluster" {
  cloud_provider {
    name = "aws"
  }

  nodes {
    address = module.nodes.addresses[0]
    internal_address = module.nodes.internal_ips[0]
    user    = module.nodes.ssh_username
    ssh_key = module.nodes.private_key
    role    = ["controlplane", "etcd"]
  }
  nodes {
    address = module.nodes.addresses[1]
    internal_address = module.nodes.internal_ips[1]
    user    = module.nodes.ssh_username
    ssh_key = module.nodes.private_key
    role    = ["worker"]
  }
  nodes {
    address = module.nodes.addresses[2]
    internal_address = module.nodes.internal_ips[2]
    user    = module.nodes.ssh_username
    ssh_key = module.nodes.private_key
    role    = ["worker"]
  }
}

resource "local_file" "kube_cluster_yaml" {
  filename = "./kube_config_cluster.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}

