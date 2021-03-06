resource "azurerm_resource_group" "fanfan" {
name = var.resource_group_name
location = var.location
}


resource "azurerm_app_service_plan" "fanfan" {

name = local.app_service_plan_name
location = azurerm_resource_group.fanfan.location
resource_group_name = azurerm_resource_group.fanfan.name
kind = "Linux"

# Reserved must be set to true for Linux App Service Plans
reserved = true

sku {
tier = "${var.plan_tier}"
size = "${var.plan_sku}"
}
}


resource "azurerm_app_service" "fanfan" {

name = local.app_service_name
location = azurerm_resource_group.fanfan.location
resource_group_name = azurerm_resource_group.fanfan.name
app_service_plan_id = azurerm_app_service_plan.fanfan.id

site_config {
always_on = true
linux_fx_version = "DOCKER|nginxdemos/hello"
}


identity {
type = "SystemAssigned"
}
}

