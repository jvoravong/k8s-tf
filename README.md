# Provision Kubernetes Clusters via Terraform

- See the README.md files in each subdirectory for steps on how to provision a cluster.
- This project currently supports using Terraform v0.14. Updates coming soon.
- Supported Clusters: aks, eks, gke
- Tip: You can use tfvars files from specific directories

```
tf apply -var-file=/Users/userx/.tfvars/varsforclusterx.tfvars
```

- Tip use `tfswitch` to download and use Terraform 0.14.0 (and other versions).

```
homebrew install tfswitch
tfswitch 0.14.0
cd ./provision-{clusterType}-cluster
terraform init
```

