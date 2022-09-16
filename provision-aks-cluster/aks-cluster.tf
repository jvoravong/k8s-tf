resource "random_pet" "prefix" {}

provider "azurem" {
  features {}
}

resource "azurerm_resource_group" "default" {
  name     = "${var.clusterName}-${random_pet.prefix.id}-rg"
  location = "West US 2"

  tags = {
    environment = "Demo"
  }
}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.clusterName}-${random_pet.prefix.id}-aks"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  network_profile {
    network_plugin = "azure"
  }

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "standard_b2s"
    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.appId
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  windows_profile {
    admin_username = "admink8stf"
    admin_password = var.password
  }

  tags = {
    Environment = "dev"
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "oswin" {
  name                  = "oswin"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.default.id
  vm_size               = "standard_b2s"
  node_count            = 2
  os_type               = "Windows"
}
