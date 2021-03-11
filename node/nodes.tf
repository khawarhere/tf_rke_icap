locals {
  cluster_id_tag = {
    "kubernetes.io/cluster/${var.cluster_id}" = "owned"
  }
}

resource "aws_security_group" "security_group_allow_all" {
  name        = "rke-default-security-group-khawar"
  description = "rke"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id      = aws_vpc.vpc.id

  tags                   = merge(
    var.common_tags,
    {
      "kubernetes.io/cluster/${var.cluster_id}" = "owned"
    },
  )
}


resource "aws_instance" "rke-node" {
  count = 2
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = "icap_us-e1_key"
  iam_instance_profile   = aws_iam_instance_profile.rke-aws.name
  security_groups = [aws_security_group.security_group_allow_all.id]
  subnet_id = aws_subnet.subnet_public.id
  tags                   = local.cluster_id_tag
  depends_on = [aws_subnet.subnet_public, aws_security_group.security_group_allow_all]

  provisioner "remote-exec" {
      connection {
        host        = coalesce(self.public_ip, self.private_ip)
        type        = "ssh"
        user        = "ubuntu"
        private_key = file("~/.ssh/icap_us-e1_key.pem")
      }

      inline = [
        "curl ${var.docker_install_url} | sh",
        "sudo usermod -a -G docker ubuntu",
        "sudo chown ubuntu:docker /var/run/docker.sock",
      ]
    }
//  provisioner "file" {
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file("~/.ssh/icap_us-e1_key.pem")
//    }
//    source      = "script.sh"
//    destination = "/tmp/script.sh"
//  }

//  provisioner "remote-exec" {
//    connection {
//      host        = coalesce(self.public_ip, self.private_ip)
//      type        = "ssh"
//      user        = "ubuntu"
//      private_key = file("~/.ssh/icap_us-e1_key.pem")
//    }
//    inline = [
//      "sudo chmod +x /tmp/script.sh",
//      "sh /tmp/script.sh",
//    ]
//  }

}