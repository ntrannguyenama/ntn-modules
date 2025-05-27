module "naming_front_door" {
  source        = "../naming"
  app_name      = var.app_name
  environment   = var.environment
  suffix        = var.suffix
  resource_type = "frontdoor"
}

resource "azurerm_frontdoor" "frontdoor" {
  name                = module.naming_front_door.resource_name
  resource_group_name = var.resource_group_name
  friendly_name       = "ScanBeton-Front-Door"

    frontend_endpoint {
    name      = "scanbeton-frontdoor-endpoint"
    host_name = "scanbeton-frontdoor-endpoint-g6g2ewcvafc4hgc9.z01.azurefd.net"
  }

  # Définir le groupe d'origines (backend pool)
  backend_pool {
    name                 = "storage-frontend"
    load_balancing_name  = "aa"
    health_probe_name    = "bb"

    # Définir un backend
    backend {
      address     = "scanbeton-backend1.com"
      host_header = "scanbeton-backend1.com"
      priority    = 1
      weight      = 50
      http_port   = 80
      https_port  = 443
    }

    backend {
      address     = "scanbeton-backend2.com"
      host_header = "scanbeton-backend2.com"
      priority    = 2
      weight      = 50
      http_port   = 80
      https_port  = 443
    }
  }

  # Définir la règle de routage
  routing_rule {
    name               = "example-routing-rule"
    accepted_protocols = ["Https", "Http"]

    forwarding_configuration {
      forwarding_protocol = "MatchRequest"
      backend_pool_name   = "storage-frontend"
    }

    patterns_to_match   = ["/*"]

    # Référence au frontend_endpoint séparé
    frontend_endpoints  = [azurerm_frontdoor_frontend_endpoint.example_frontend_endpoint.id]
  }

  backend_pool_health_probe {
    name = "test1"
  }

  backend_pool_load_balancing {
    name = "test2"
  }
}

# Définir le frontend endpoint séparément
resource "azurerm_frontdoor_frontend_endpoint" "example_frontend_endpoint" {
  name      = "scanbeton-frontdoor-endpoint"
  host_name = "scanbeton-frontdoor-endpoint-g6g2ewcvafc4hgc9.z01.azurefd.net"
  frontdoor_id = azurerm_frontdoor.frontdoor.id
}

