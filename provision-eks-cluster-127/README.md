# Learn Terraform - Provision an EKS Cluster

This repo is a companion repo to the [Provision an EKS Cluster learn guide](https://learn.hashicorp.com/terraform/kubernetes/provision-eks-cluster), containing
Terraform configuration files to provision an EKS cluster on AWS.

# Provision A Cluster Quickly
1) Replace the values in your terraform.tfvars file with your region.
   cluster_name = "clustername-x-eks-1.27"
   cluster_version = "1.27"
   cluster_owner = "owner-x"
   region     = "us-east-1"
2) Authorize with AWS (Region: us-east-1)
3) terraform init
4) terraform apply
5) aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

# Add the EKS Helm chart repository
helm repo add eks-charts https://aws.github.io/eks-charts

# Create a namespace for the EKS controller
kubectl create namespace ack-eks-controller

# Install the EKS controller
helm install -n ack-eks-controller ack-eks-controller eks-charts/ack-eks-controller
