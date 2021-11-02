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

Policy definition is in tagging-policy.json file, packer template in server.json file and terraform template in main.tf file. Detailed instructions on how to use those files are given in "Instructions" section.
Using Azure CLI connect to your Azure account to deploy your infrastructure.

1. Run packer build on Packer template. This will create Packer image.
```
$ packer build server.json
```

2. Check your infrastructure using terraform plan on terraform template. Then apply that infrastructure using command terraform apply.
```
$ terraform plan -out solution.plan
$ terraform apply "solution.plan"
```

Variables defined in variables.tf file ensure that the parameters which define infrastructure can be changed. For example, number of virtual machines on a server can be user defined.

### Output
**Your words here**

