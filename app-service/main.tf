data "azurerm_client_config" "current" {}

resource "azurerm_service_plan" "main" {
  name                = module.naming_app_service_plan.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type            = local.os_type
  sku_name           = local.sku_name
  worker_count = local.worker_count

  tags = local.tags
}

resource "azurerm_linux_web_app" "main" {
  for_each = {
    for web_app in var.web_app : "${module.naming_app_service.resource_name}-${var.var.web_app.suffix}" => web_app
  }

   name                = module.naming_app_service.resource_name
   resource_group_name = var.resource_group_name
   location            = var.location
   service_plan_id     = azurerm_service_plan.main.id
 
   site_config {
     application_stack {
       node_version = local.node_version
     }
     always_on = false
     app_command_line = local.app_command_line
     cors {
      allowed_origins = local.allowed_origins
      support_credentials = local.support_credentials
     }
   }
   app_settings = var.web_app.app_settings
   identity {
     type = "SystemAssigned"
   }
 
   tags = local.tags
 }