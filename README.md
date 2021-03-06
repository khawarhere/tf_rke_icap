# How To Deploy Kubernetes Clusters on AWS using Terraform and Terraform RKE Provider

This repository is an examples for building a Kubernetes cluster using Terraform and Terraform RKE provider on AWS.


## How to use

### Requirements

- [terraform](https://terraform.io) v0.11+
- [terraform-provider-rke](https://github.com/rancher/terraform-provider-rke)
- Valid AWS access_key and secret_key
- [optional] `kubectl` command

### Deploy Kubernetes Cluster on AWS

```console
#clone this repo
$ git clone https://github.com/khawarhere/tf_rke_icap.git
$ cd tf_rke_icap

#create a file `terraform.tfvars` in root folder, set following parameters:
region = "us-east-1"
AWS_ACCESS_KEY_ID = "xxxxxxxxxxxxxx"
AWS_SECRET_ACCESS_KEY = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"

#deploy
$ terraform init && terraform apply

###########################################################################
#When "terraform apply" is completed, 
#kubeconfig file should be created in the current directory 
###########################################################################

#set KUBECONFIG environment variable for kubectl 
$ export KUBECONFIG=${PWD}/kube_config_cluster.yml 

###########################################################################
#Then, kubectl command can be used
###########################################################################

#component statuses
$ kubectl get cs

NAME                 STATUS    MESSAGE              ERROR
controller-manager   Healthy   ok                   
scheduler            Healthy   ok                   
etcd-0               Healthy   {"health": "true"}  

#nodes
$ kubectl get nodes

NAME                                             STATUS    ROLES               AGE       VERSION
ip-xx-xx-xx-xx.ap-northeast-1.compute.internal   Ready     controlplane,etcd   1m        v1.10.1
ip-xx-xx-xx-xx.ap-northeast-1.compute.internal   Ready     worker              1m        v1.10.1
ip-xx-xx-xx-xx.ap-northeast-1.compute.internal   Ready     worker              1m        v1.10.1
ip-xx-xx-xx-xx.ap-northeast-1.compute.internal   Ready     worker              1m        v1.10.1
```

