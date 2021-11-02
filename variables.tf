variable "managed_image_name" {
    type = string
    description = "Name of the managed image"
    default = "myPackerImage" #from server.json
}
variable "managed_image_resource_group_name" {
    type = string
    description = "Name of the managed image resource group"
    default = "packer-rg" #from server.json
}

variable "prefix" {
    type = string
    description = "The prefix which should be used for all resources in this project."
    default = "udacity-1st-project"
}

variable "location" {
    type = string
    description = "The Azure Region in which all resources in this project should be created."
    default = "westeurope"
}

variable "admin_username" {
    type = string
    description = "Username for the VM admin user"
    default = "adminUser!"
}

variable "admin_password" {
    type = string
    description = "Password for the VM admin user"
    default = "12345abcdE"
}

variable "vm_num"{
    type = number
    description = "Number of VMs"
    default = 2
    validation{
    condition = var.vm_num > 1 && var.vm_num < 6
    error_message = "Invalid number of VMs."
  }
}

variable "common_tags" {
  type        = map
  description = "Common tags used for tagging project resources."
  default     = {
    "Project" = "Udacity-1st"
    "Purpose" = "Learning"
  }
}
