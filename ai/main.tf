module "naming_openai" {
  source = "../naming"

  app_name      = var.app_name
  environment   = var.environment
  suffix        = var.suffix
  resource_type = "openai"
}


module "naming_speech" {
  source        = "../naming"
  app_name      = var.app_name
  environment   = var.environment
  suffix        = null
  resource_type = "speech"
}


resource "azurerm_cognitive_account" "openai" {
  name                = module.naming_openai.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name
  kind                = "OpenAI"
  sku_name            = "S0"
  tags                = var.tags
  custom_subdomain_name = module.naming_openai.resource_name

  identity {
    type = "SystemAssigned"
  }
}


resource "azurerm_cognitive_account" "speech_service" {
  name                = module.naming_speech.resource_name
  location            = var.location
  resource_group_name = var.resource_group_name

  kind     = "SpeechServices"
  sku_name = "S0"

  tags = {
    environment = "demo"
    service     = "speech"
  }
}