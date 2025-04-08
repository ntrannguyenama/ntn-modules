locals {
     sku_name = var.web_app.sku_name != null ? var.web_app.sku_name : "B1"
     os_type = var.web_app.os_type != null ? var.web_app.os_type : "Linux"
     worker_count = var.web_app.worker_count != null ? var.web_app.worker_count : 1 
}