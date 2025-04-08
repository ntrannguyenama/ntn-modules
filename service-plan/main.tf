module "naming_app_service_plan" {
  source        = "../naming"
  app_name      = var.app_name
  environment   = var.environment
  suffix        = ""
  resource_type = "appsp"
}

resource "azurerm_service_plan" "main" {
  name                = module.naming_app_service_plan.resource_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type            = local.web_app.os_type
  sku_name           = local.web_app.sku_name
  worker_count = local.web_app.worker_count

  tags = local.web_app.tags
}