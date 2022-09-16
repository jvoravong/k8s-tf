# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster), containing
Terraform configuration files to provision an EKS cluster on AWS.

# Provision A Cluster Quickly
1) Replace the values in your terraform.tfvars file with your project_id and region.
2) Authorize with AWS (Region: us-east-1)
3) terraform init
4) terraform apply
5) aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)