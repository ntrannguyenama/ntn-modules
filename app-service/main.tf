data "azurerm_client_config" "current" {}

resource "azurerm_linux_web_app" "main" {
   name                = var.name
   resource_group_name = var.resource_group_name
   location            = var.location
   service_plan_id     = var.service_plan_id
 
   site_config {
     application_stack {
       node_version = local.web_app.node_version
     }
     always_on = false
     app_command_line = local.web_app.app_command_line
     cors {
      allowed_origins = local.web_app.allowed_origins
      support_credentials = local.web_app.support_credentials
     }
   }
   app_settings = var.web_app.app_settings
   identity {
     type = "SystemAssigned"
   }
 
   tags = local.merged_tags
 }