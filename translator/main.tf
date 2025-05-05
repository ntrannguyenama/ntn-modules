module "naming_translator" {
  source = "../naming"

  app_name      = var.app_name
  environment   = var.environment
  suffix        = var.suffix
  resource_type = "translator"
}

resource "azurerm_cognitive_account" "translator" {
  name                = module.naming_translator
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "TextTranslation"
  sku_name            = "S0"

  tags = {
    environment = "dev"
  }
}