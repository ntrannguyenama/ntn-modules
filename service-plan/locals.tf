locals {
     sku_name = var.service_plan.sku_name != null ? var.service_plan.sku_name : "B1"
     os_type = var.service_plan.os_type != null ? var.service_plan.os_type : "Linux"
     worker_count = var.service_plan.worker_count != null ? var.service_plan.worker_count : 1 

     tags = var.tags
}