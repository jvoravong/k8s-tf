# Learn Terraform - Provision AKS Cluster

This repo is a companion repo to the [Provision an AKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-aks-cluster), containing Terraform configuration files to provision an AKS cluster on Azure.

# Provision A Cluster Quickly
1) az ad sp create-for-rbac --skip-assignment
2) Replace the values in your terraform.tfvars file with your appId, password adn clustername.
3) az login
4) terraform init
5) terraform apply
6) az aks get-credentials --resource-group $(terraform output -raw resource_group_name) --name $(terraform output -raw kubernetes_cluster_name)