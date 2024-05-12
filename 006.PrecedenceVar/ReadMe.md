# Variable Preecdences

# command line variables
Pass values part of command line arguments

Example : terraform plan --var state=Karnataka


# Variables Precedence
1. command line arguments
2. *.auto.tfvars
3. terraform.tfvars
4. Shell environment variables

Terraform Version - Version of the terraform software
Provider version - Cloud Provider version

# A sample terraform provider

terraform{
    required_providers{
        prod={
            source="hashicorp/azurerm",
            version="1.0"
        }
        dev={
            source="hashicorp/azurerm",
            version="2.0"
        }
    }
}


terraform{
    required_providers{
        prod={
            source="hashicorp/azurerm",
            version="~> 2.90"
        }
        dev={
            source="hashicorp/azurerm",
            version="~> 2.70"
        }
    }
    required_version=">= 1.0.5" # greater than or equal to version 1.0.5
}

# required_version is terraform version
# version is cloud provider version

# From v0.12, the provider declaration is not mandatory, Based on the resource it can pick the provider version

# latest version will be used if provider version is not specified


