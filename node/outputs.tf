//output "private_key" {
//  value = tls_private_key.node-key.private_key_pem
//}

output "ssh_username" {
  value = "ubuntu"
}

output "addresses" {
  value = aws_instance.rke-node[*].public_dns
}

output "internal_ips" {
  value = aws_instance.rke-node[*].private_ip
}

output "public_ips" {
  value = aws_instance.rke-node[*].public_ip
}

//output "public_ip_controlplan" {
//  value = aws_instance.rke-node[0].public_ip
//}