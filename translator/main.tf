module "naming_translator" {
  source = "../naming"

  app_name      = var.app_name
  environment   = var.environment
  suffix        = var.suffix
  resource_type = "translator"
}

resource "azurerm_cognitive_account" "translator" {
  name                = module.naming_translator
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "TextTranslation"
  sku_name            = "S0"

  tags = {
    environment = "dev"
  }
}