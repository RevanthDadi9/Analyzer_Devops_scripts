output "react_storage_account_url" {
  description = "The URL of the React app hosted in the storage account."
  value       = azurerm_storage_account.react_storage_account.primary_web_host
}

output "front_door_url" {
  description = "The Front Door URL for the React frontend."
  value       = azurerm_frontdoor.frontend_door.frontend_endpoint[0].host_name
}
