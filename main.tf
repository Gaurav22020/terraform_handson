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
  depends_on          = [module.resource_group]

}
module "pip" {
  source              = "./publicip"
  pip_name            = "pip-1"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  depends_on          = [module.resource_group]
}
module "nic" {
  source              = "./interfacecard"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  nic_name            = "nic"
  pip_id              = module.pip.pip_id
  subnet_id           = module.vnet.subnet_id
  depends_on          = [module.vnet]


}
module "nsg" {
  source              = "./securitygroup"
  nsg_name            = "nsg"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  subnet_id           = module.vnet.subnet_id
  depends_on          = [module.vnet]
}
module "vm" {
  source              = "./compute"
  vm_name             = "vm1"
  resource_group_name = module.resource_group.resource_group_name
  location            = module.resource_group.location
  nic_id              = module.nic.nic_id
  username            = "Gaurav"
  depends_on          = [module.resource_group, module.vnet, module.nic]
}
