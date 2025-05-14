provider "azurerm" {
  features {}

  subscription_id = "c77c1ca7-0511-497c-84bd-2b785c7a7225" # Replace with your actual subscription ID
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = "rg-react-app"
  location = var.location
}

# Storage Account for React app static files
resource "azurerm_storage_account" "react_storage_account" {
  name                     = "reactstorageacct"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Blob Container to hold React app files
resource "azurerm_storage_container" "react_container" {
  name                  = "react-container"
  storage_account_id    = azurerm_storage_account.react_storage_account.id
  container_access_type = "blob"
}

# Front Door to serve the app globally
resource "azurerm_frontdoor" "frontend_door" {
  name                = "react-frontend-door"
  resource_group_name = azurerm_resource_group.rg.name
  friendly_name       = "React Frontend"

  backend_pool {
    name                = "react-backend-pool"
    load_balancing_name = "react-load-balancer"
    health_probe_name   = "react-health-probe"
    backend {
      host_header = azurerm_storage_account.react_storage_account.primary_web_host
      address     = azurerm_storage_account.react_storage_account.primary_web_host
      http_port   = 80
      https_port  = 443
      enabled     = true
    }
  }

  backend_pool_health_probe {
    name                = "react-health-probe"
    protocol            = "Https"
    path                = "/"
    interval_in_seconds = 30
  }

  backend_pool_load_balancing {
    name                            = "react-load-balancer"
    additional_latency_milliseconds = 0
  }

  routing_rule {
    name               = "react-routing-rule"
    accepted_protocols = ["Https"]
    patterns_to_match  = ["/*"]
    frontend_endpoints = ["react-endpoint"]
    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "react-backend-pool"
    }
  }

  frontend_endpoint {
    name      = "react-endpoint"
    host_name = "your-app-frontdoor.azurefd.net"
  }
}
