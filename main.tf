terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "main" {
  name     = "${var.prefix}-resources"
  location = var.location
}

# Create a virtual network within the resource group
resource "azurerm_virtual_network" "main" {
  name                = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  address_space       = ["10.0.0.0/16"]
  tags = var.common_tags
}

# Create a subnet within VN
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Create a network security group
resource "azurerm_network_security_group" "main"{
    name = "${var.prefix}-nsg"
    resource_group_name = azurerm_resource_group.main.name
    location = azurerm_resource_group.main.location
    tags = var.common_tags

    security_rule{
        name = "subnet-access"
        description = "Allow access to VMs via subnet."
        priority = 101
        direction = "Outbound"
        access = "Allow"
        protocol = "*"
        source_address_prefix = "10.0.2.0/24"
        source_port_range = "*"
        destination_port_range = "*"
        destination_address_prefix = "VirtualNetwork"
    }

    security_rule{
        name = "internet-access"
        description = "Deny access to VMs via internet."
        priority = 100
        direction = "Inbound"
        access = "Deny"
        protocol = "*"
        source_address_prefix = "Internet"
        source_port_range = "*"
        destination_port_range = "*"
        destination_address_prefix = "VirtualNetwork"
    }
}

# Create a network interface
resource "azurerm_network_interface" "main" {
  count = var.vm_num
  name                = "${var.prefix}-nic${count.index + 1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags = var.common_tags
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Create a public IP
resource "azurerm_public_ip" "main" {
  name                = "${var.prefix}-pubIP"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"
  tags = var.common_tags
}

# Create a load balancer
resource "azurerm_lb" "main" {
  name                = "${var.prefix}-LoadBalancer"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  tags = var.common_tags
  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.main.id
  }
}

resource "azurerm_lb_backend_address_pool" "main" {
  name                = "${var.prefix}-BackEndAddressPool"
  loadbalancer_id     = azurerm_lb.main.id
}

resource "azurerm_network_interface_backend_address_pool_association" "main"{
    count = var.vm_num
    network_interface_id = azurerm_network_interface.main[count.index].id
    ip_configuration_name = "internal"
    backend_address_pool_id = azurerm_lb_backend_address_pool.main.id
}

# Create a VM availability set
resource "azurerm_availability_set" "main" {
  name                = "${var.prefix}-aset"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  platform_fault_domain_count = var.vm_num
  platform_update_domain_count = var.vm_num
  tags = var.common_tags
}

# Create managed disks for your VMs
resource "azurerm_managed_disk" "source" {
  count = var.vm_num
  name                 = "${var.prefix}-md${count.index + 1}"
  location             = azurerm_resource_group.main.location
  resource_group_name  = azurerm_resource_group.main.name
  storage_account_type = "Standard_LRS"
  create_option        = "Empty"
  disk_size_gb         = "1"
  tags = var.common_tags
}

#Create VMs
data "azurerm_image" "customimage" {
   name                = "${var.managed_image_name}"
   resource_group_name = "${var.managed_image_resource_group_name}"
}

resource "azurerm_linux_virtual_machine" "main" {
  count = var.vm_num
  name                            = "${var.prefix}-vm${count.index + 1}"
  resource_group_name             = azurerm_resource_group.main.name
  location                        = azurerm_resource_group.main.location
  size                            = "Standard_D2s_v3"
  admin_username                  = "${var.admin_username}"
  admin_password                  = "${var.admin_password}"
  disable_password_authentication = false
  availability_set_id = azurerm_availability_set.main.id
  tags = var.common_tags
  
  network_interface_ids = [
    azurerm_network_interface.main[count.index].id,
  ]

    source_image_id = data.azurerm_image.customimage.id

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }
}