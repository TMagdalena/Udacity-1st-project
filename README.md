# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure

### Introduction
For this project, you will write a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure.

### Getting Started
1. Clone this repository

2. Create your infrastructure as code

3. Update this README to reflect how someone would use your code.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

Policy definition is in `tagging-policy.json` file, packer template in `server.json` file and terraform template in `main.tf` file. Detailed instructions on how to use those files are given below.
Using Azure CLI connect to your Azure account to deploy your infrastructure.

1. Run `packer build` on Packer template. This will create Packer image.
```
$ packer build server.json
```

2. Check your infrastructure using `terraform plan` on terraform template. Then apply that infrastructure using command `terraform apply`.
```
$ terraform plan -out solution.plan
$ terraform apply "solution.plan"
```

Variables defined in `variables.tf` file ensure that the parameters which define infrastructure can be changed. For example, number of virtual machines on a server can be user defined.

### Output
azurerm_resource_group.main: Creating...
azurerm_resource_group.main: Creation complete after 1s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources]
azurerm_virtual_network.main: Creating...
azurerm_availability_set.main: Creating...
azurerm_managed_disk.source[0]: Creating...
azurerm_public_ip.main: Creating...
azurerm_managed_disk.source[1]: Creating...
azurerm_network_security_group.main: Creating...
azurerm_availability_set.main: Creation complete after 2s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Compute/availabilitySets/udacity-1st-project-aset]
azurerm_public_ip.main: Creation complete after 3s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/publicIPAddresses/udacity-1st-project-pubIP]
azurerm_lb.main: Creating...
azurerm_managed_disk.source[1]: Creation complete after 3s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Compute/disks/udacity-1st-project-md2]
azurerm_managed_disk.source[0]: Creation complete after 3s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Compute/disks/udacity-1st-project-md1]
azurerm_lb.main: Creation complete after 1s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/loadBalancers/udacity-1st-project-LoadBalancer]
azurerm_lb_backend_address_pool.main: Creating...
azurerm_network_security_group.main: Creation complete after 5s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/networkSecurityGroups/udacity-1st-project-nsg]
azurerm_virtual_network.main: Creation complete after 5s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/virtualNetworks/udacity-1st-project-network]
azurerm_subnet.internal: Creating...
azurerm_lb_backend_address_pool.main: Creation complete after 2s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/loadBalancers/udacity-1st-project-LoadBalancer/backendAddressPools/udacity-1st-project-BackEndAddressPool]
azurerm_subnet.internal: Creation complete after 4s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/virtualNetworks/udacity-1st-project-network/subnets/internal]
azurerm_network_interface.main[1]: Creating...
azurerm_network_interface.main[0]: Creating...
azurerm_network_interface.main[1]: Creation complete after 2s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/networkInterfaces/udacity-1st-project-nic2]
azurerm_network_interface.main[0]: Creation complete after 4s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/networkInterfaces/udacity-1st-project-nic1]
azurerm_network_interface_backend_address_pool_association.main[1]: Creating...
azurerm_network_interface_backend_address_pool_association.main[0]: Creating...
azurerm_linux_virtual_machine.main[0]: Creating...
azurerm_linux_virtual_machine.main[1]: Creating...
azurerm_network_interface_backend_address_pool_association.main[0]: Creation complete after 1s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/networkInterfaces/udacity-1st-project-nic1/ipConfigurations/internal|/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/loadBalancers/udacity-1st-project-LoadBalancer/backendAddressPools/udacity-1st-project-BackEndAddressPool]
azurerm_network_interface_backend_address_pool_association.main[1]: Creation complete after 1s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/networkInterfaces/udacity-1st-project-nic2/ipConfigurations/internal|/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Network/loadBalancers/udacity-1st-project-LoadBalancer/backendAddressPools/udacity-1st-project-BackEndAddressPool]
azurerm_linux_virtual_machine.main[1]: Still creating... [10s elapsed]
azurerm_linux_virtual_machine.main[0]: Still creating... [10s elapsed]
azurerm_linux_virtual_machine.main[1]: Still creating... [20s elapsed]
azurerm_linux_virtual_machine.main[0]: Still creating... [20s elapsed]
azurerm_linux_virtual_machine.main[0]: Still creating... [30s elapsed]
azurerm_linux_virtual_machine.main[1]: Still creating... [30s elapsed]
azurerm_linux_virtual_machine.main[0]: Still creating... [40s elapsed]
azurerm_linux_virtual_machine.main[1]: Still creating... [40s elapsed]
azurerm_linux_virtual_machine.main[1]: Creation complete after 47s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Compute/virtualMachines/udacity-1st-project-vm2]
azurerm_linux_virtual_machine.main[0]: Creation complete after 47s [id=/subscriptions/abddf813-82d4-4432-86c9-9052d9dcff63/resourceGroups/udacity-1st-project-resources/providers/Microsoft.Compute/virtualMachines/udacity-1st-project-vm1]
