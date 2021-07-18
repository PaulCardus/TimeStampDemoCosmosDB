output "webapp_url" {
  value = azurerm_app_service.webapp.default_site_hostname
}

output "webapp_ips" {
  value = azurerm_app_service.webapp.outbound_ip_addresses
}

output "cosmosdb_endpoint" {
  value     = azurerm_cosmosdb_account.db.endpoint
  sensitive = true
}

output "cosmosdb_key" {
  value     = azurerm_cosmosdb_account.db.primary_key
  sensitive = true
}
