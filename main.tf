module "resource_group" {
  source              = "./resourcegroup"
  resource_group_name = "myrg"
  location            = "centralindia"


}
module "vnet" {
  source              = "./network"
  vn_name             = "vnet1"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  subnet_name         = "subnet1"
  address_space       = "10.0.0.0/16"
  address_prefix      = "10.0.1.0/24"

}
