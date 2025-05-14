output "node_vm_public_ip" {
  description = "Public IP address of the Node API VM"
  value       = azurerm_public_ip.node_public_ip.ip_address
}

output "flask_vm_public_ip" {
  description = "Public IP address of the Flask API VM"
  value       = azurerm_public_ip.flask_public_ip.ip_address
}

output "vnet_id" {
  description = "ID of the created Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "node_subnet_id" {
  description = "ID of the Node subnet"
  value       = azurerm_subnet.node_subnet.id
}

output "flask_subnet_id" {
  description = "ID of the Flask subnet"
  value       = azurerm_subnet.flask_subnet.id
}
