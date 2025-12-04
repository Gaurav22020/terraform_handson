resource "azurerm_virtual_network" "Vnet" {
  name                = var.vn_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.address_space]

}
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  virtual_network_name = var.vn_name
  resource_group_name  = var.resource_group_name
  address_prefixes     = [var.address_prefix]

}
